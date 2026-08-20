import os
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sqlalchemy.orm import Session
from fastapi.staticfiles import StaticFiles
from backend.database import engine, SessionLocal
from backend import models

app = FastAPI()
models.Base.metadata.create_all(bind=engine)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
class WallpaperCreate(BaseModel):
    category: str
    url: str
    title: str


def get_db():
    db = SessionLocal()

    try:
        yield db
    finally:
        db.close()
@app.get("/")
def home():
    return {"message": "OG Wallpaper API is running"}

app.mount("/images", StaticFiles(directory="assets/image"), name="images")
@app.get("/wallpapers/{category}")
def get_wallpapers(
    category: str,
    db: Session = Depends(get_db)
):
    wallpapers = db.query(models.Wallpaper).filter(
        models.Wallpaper.category == category
    ).all()

    return {
        "category": category,
        "images": [wallpaper.url for wallpaper in wallpapers]
    }
@app.post("/wallpapers")
def add_wallpaper(
    wallpaper: WallpaperCreate,
    db: Session = Depends(get_db),
):
    new_wallpaper = models.Wallpaper(
        category=wallpaper.category,
        url=wallpaper.url,
        title=wallpaper.title,
    )

    db.add(new_wallpaper)
    db.commit()
    db.refresh(new_wallpaper)

    return new_wallpaper

@app.post("/import-wallpapers")
def import_wallpapers(db: Session = Depends(get_db)):

    base_folder = "assets/image"
    added = 0

    for category in os.listdir(base_folder):

        category_path = os.path.join(base_folder, category)

        if not os.path.isdir(category_path):
            continue

        for filename in os.listdir(category_path):

            if not filename.lower().endswith(
                (".png", ".jpg", ".jpeg", ".webp")
            ):
                continue

            image_url = (
                f"http://127.0.0.1:8000/images/"
                f"{category}/{filename}"
            )

            existing = db.query(models.Wallpaper).filter(
                models.Wallpaper.url == image_url
            ).first()

            if existing:
                continue

            new_wallpaper = models.Wallpaper(
                category=category.capitalize(),
                url=image_url,
                title=os.path.splitext(filename)[0]
            )

            db.add(new_wallpaper)
            added += 1

    db.commit()

    return {
        "message": "Wallpapers imported successfully",
        "added": added
    }
from sqlalchemy import Column, Integer, String
from .database import Base


class Wallpaper(Base):
    __tablename__ = "wallpapers"

    id = Column(Integer, primary_key=True, index=True)
    category = Column(String, index=True)
    url = Column(String)
    title = Column(String)
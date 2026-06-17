from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
<<<<<<< HEAD
    return {"message": "Backend is running: v2"}
=======
    return {"message": "Backend is running: v1"}
>>>>>>> 62b37d7 (change version)

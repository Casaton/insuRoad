from flask import Flask, request, jsonify
from flask_cors import CORS
import json
import os

app = Flask(__name__)

CORS(app) 

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CARS_PATH = os.path.join(BASE_DIR, "..", "base", "cars.json")

@app.route("/", methods=["GET"])
def index():
    return """
    <center>
    <br/><br/><br/>
    Це API, а не сайт 🙂<br>
    Використовуйте <b>/api/search</b>
    </center>
    """

@app.route("/api/search", methods=["POST", "OPTIONS"])
def search_car():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"})

    data = request.json or {}
    plate = data.get("plate", "").upper()

    with open(CARS_PATH, "r", encoding="utf-8") as f:
        cars = json.load(f)

    for car in cars:
        if car.get("plate", "").upper() == plate:
            return jsonify({
                "status": "found",
                "manufacturer": car["manufacturer"],
                "model": car["model"],
                "year": car["year"],
                "engine_volume": car["engine_volume"],
                "vin": car["vin"],
                "seats": car["seats"],
                "full_weight": car["full_weight"],
                "empty_weight": car["empty_weight"]
            })

    return jsonify({"status": "not_found"})


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)

const btn = document.getElementById("searchBtn");
const input = document.getElementById("plateInput");
const status = document.getElementById("status");

const stepSearch = document.getElementById("step-search");
const stepResult = document.getElementById("step-result");

btn.addEventListener("click", () => {
  const plate = input.value.trim().toUpperCase();
  status.textContent = "";
  status.className = "status";

  if (!plate) {
    status.textContent = "Введіть номерний знак";
    status.classList.add("error");
    return;
  }

  status.textContent = "Пошук...";

const API_URL =
  location.protocol === "file:"
    ? "http://127.0.0.1:5000/api"
    : location.hostname === "127.0.0.1" || location.hostname === "localhost"
    ? "http://127.0.0.1:5000/api"
    : "https://user.pythonanywhere.com/api";


  fetch(`${API_URL}/search`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ plate }),
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.status !== "found") {
        status.textContent = "Авто з таким номерним знаком НЕ ЗНАЙДЕНО!!!";
        status.classList.add("error");
        return;
      }

      document.getElementById("manufacturer").textContent = data.manufacturer;
      document.getElementById("model").textContent = data.model;
      document.getElementById("year").textContent = data.year;
      document.getElementById("engine").textContent = data.engine_volume;
      document.getElementById("vin").textContent = data.vin;
      document.getElementById("seats").textContent = data.seats;
      document.getElementById("fullWeight").textContent = data.full_weight;
      document.getElementById("emptyWeight").textContent = data.empty_weight;

      stepSearch.classList.add("hidden");
      stepResult.classList.remove("hidden");
    })
    .catch(() => {
      status.textContent = "Помилка з'єднання";
      status.classList.add("error");
    });
});

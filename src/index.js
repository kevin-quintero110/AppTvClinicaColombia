import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import "./index.css";
import App from "./App";
import Formulario from "./formulario";

// ✅ Validación para evitar el error de HTMLOUT
if (typeof window.HTMLOUT === "undefined") {
  window.HTMLOUT = {
    log: (msg) => console.log("[HTMLOUT mock]", msg),
    // Puedes agregar más funciones si las necesitas
  };
}

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <Router>
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/formulario" element={<Formulario />} />
      </Routes>
    </Router>
  </React.StrictMode>
);
import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ status: "ok" });
});

app.post("/chat", async (req, res) => {
  try {
    const message = req.body.message ?? "";

    if (!message.trim()) {
      return res.status(400).json({ error: "Message is required." });
    }

    const response = await fetch("https://api.openai.com/v1/responses", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${process.env.OPENAI_API_KEY}`
      },
      body: JSON.stringify({
        model: "gpt-5.4-mini",
        input: message
      })
    });

    if (!response.ok) {
      const errorText = await response.text();
      return res.status(response.status).json({ error: errorText });
    }

    const data = await response.json();

    const reply = data.output?.[0]?.content?.[0]?.text ?? "Sorry, I could not read the model response.";

    res.json({ reply });
  } catch (error) {
    console.error("Chat route error:", error);
    res.status(500).json({ error: "Internal server error." });
  }
});


const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log("API KEY LOADED:", process.env.OPENAI_API_KEY ? "YES" : "NO");
});

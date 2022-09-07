import { opine } from "./deps.ts";

const app = opine();

app.get("/", (_req, res) => {
  res.send("Hello World");
});

app.listen(
  3000,
  () => console.log("server has started on http://localhost:3000 🚀"),
);

"use client"; // ← クライアントコンポーネント化する宣言

import { useEffect, useState } from "react";

type HelloResponse = {
  message: string;
  status?: string;
  data?: number[];
};

export default function ApiSamplePage() {
  const [data, setData] = useState<HelloResponse | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    // RailsのAPI (http://localhost:3000/hello) をフェッチする
    fetch("http://localhost:3000/hello")
      .then((res) => {
        if (!res.ok) {
          throw new Error(`Fetch Error: ${res.status}`);
        }
        return res.json();
      })
      .then((json: HelloResponse) => {
        setData(json);
      })
      .catch((err) => {
        setError(err.message);
      });
  }, []);

  return (
    <main style={{ padding: 20 }}>
      <h1>API Sample Page</h1>
      {error && <p style={{ color: "red" }}>Error: {error}</p>}
      {data ? (
        <div style={{ marginTop: 10 }}>
          <p>Message: {data.message}</p>
          <p>Status: {data.status}</p>
          <p>Data: {data.data?.join(", ")}</p>
        </div>
      ) : (
        <p>Loading...</p>
      )}
    </main>
  );
}
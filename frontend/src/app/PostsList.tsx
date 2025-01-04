"use client";

import { useEffect, useState } from "react";

type Post = {
  id: number;
  title: string;
  image_url: string;
  description: string;
  user_id: number;
};

export default function PostsList() {
  const [posts, setPosts] = useState<Post[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch("http://localhost:3000/posts")
      .then((res) => {
        if (!res.ok) {
          throw new Error(`Fetch Error: ${res.status}`);
        }
        return res.json();
      })
      .then((data: Post[]) => {
        setPosts(data);
      })
      .catch((err) => {
        setError(err.message);
      });
  }, []);

  return (
  <div className="p-4">
    <h1 className="text-2xl font-bold mb-4">Posts List</h1>
    {error && <p className="text-red-500">Error: {error}</p>}
    {posts.length > 0 ? (
      <ul className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        {posts.map((post) => (
          <li key={post.id} className="p-4 rounded shadow transition-transform transform hover:scale-105 hover:brightness-110">
            <h2 className="text-xl font-semibold whitespace-nowrap overflow-hidden text-ellipsis max-w-full">{post.title}</h2>
            <img
              src={post.image_url}
              alt={post.title}
              className="w-full h-auto mt-2"
            />
            <p className="mt-2">{post.description}</p>
          </li>
        ))}
      </ul>
    ) : (
      <p>Loading...</p>
    )}
  </div>
);
}

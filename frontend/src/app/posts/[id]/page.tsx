"use client";

import { useParams } from "next/navigation";
import { useEffect, useState } from "react";

type Post = {
  id: number;
  title: string;
  image_url: string;
  description: string;
  user_id: number;
};

export default function PostDetail() {
  const { id } = useParams();
  const [post, setPost] = useState<Post | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(`http://localhost:3000/posts/${id}`)
      .then((res) => {
        if (!res.ok) {
          throw new Error(`Fetch Error: ${res.status}`);
        }
        return res.json();
      })
      .then((data: Post) => {
        setPost(data);
      })
      .catch((err) => {
        setError(err.message);
      });
  }, [id]);

  if (error) {
    return <div className="p-4 text-red-500">Error: {error}</div>;
  }

  if (!post) {
    return <div className="p-4">Loading...</div>;
  }

  return (
    <div className="p-4 max-w-4xl mx-auto">
      <h1
        className="text-3xl font-bold mb-4"
        data-view-transition-name={`title-${post.id}`}
      >
        {post.title}
      </h1>
      <img
        src={post.image_url}
        alt={post.title}
        className="w-full h-auto rounded-lg mb-4"
        data-view-transition-name={`image-${post.id}`}
      />
      <p className="text-gray-700">{post.description}</p>
    </div>
  );
}

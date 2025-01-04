import { render, screen, waitFor } from "@testing-library/react";
import PostsList from "./PostsList";
import { rest } from "msw";
import { setupServer } from "msw/node";

const server = setupServer(
  rest.get("http://localhost:3000/posts", (req, res, ctx) => {
    return res(
      ctx.json([
        {
          id: 1,
          title: "Post One",
          image_url: "https://example.com/post1.png",
          description: "Description One",
          user_id: 1,
        },
        {
          id: 2,
          title: "Post Two",
          image_url: "https://example.com/post2.png",
          description: "Description Two",
          user_id: 1,
        },
      ])
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

test("fetches and displays posts", async () => {
  render(<PostsList />);

  await waitFor(() => {
    expect(screen.getByText("Post One")).toBeInTheDocument();
    expect(screen.getByText("Post Two")).toBeInTheDocument();
  });
});

test("displays error message on fetch failure", async () => {
  server.use(
    rest.get("http://localhost:3000/posts", (req, res, ctx) => {
      return res(ctx.status(500));
    })
  );

  render(<PostsList />);

  await waitFor(() => {
    expect(screen.getByText(/Error:/)).toBeInTheDocument();
  });
});

class HelloController < ApplicationController
  def index
    render json: { message: "Hello from Rails API!", status: "OK", data: [1, 2, 3] }
  end
end
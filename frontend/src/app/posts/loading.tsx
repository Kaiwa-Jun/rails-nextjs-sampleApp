import React from 'react';

const Loading = () => {
  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4">Loading...</h1>
      <ul className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        {Array.from({ length: 6 }).map((_, index) => (
          <li key={index} className="p-4 rounded shadow bg-gray-200 animate-pulse">
            <div className="h-6 bg-gray-300 mb-2"></div>
            <div className="w-full h-40 bg-gray-300"></div>
            <div className="h-4 bg-gray-300 mt-2"></div>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Loading;

import React from 'react';
import './SearchBar.css';

function SearchBar({ searchQuery, onSearchChange }) {
  return (
    <div className="search-bar">
      <input
        type="text"
        placeholder="메모 검색..."
        value={searchQuery}
        onChange={(e) => onSearchChange(e.target.value)}
        className="search-input"
      />
      {searchQuery && (
        <button
          className="search-clear"
          onClick={() => onSearchChange('')}
          aria-label="검색 초기화"
        >
          ✕
        </button>
      )}
    </div>
  );
}

export default SearchBar;

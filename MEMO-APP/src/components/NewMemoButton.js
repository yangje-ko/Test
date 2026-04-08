import React from 'react';
import './NewMemoButton.css';

function NewMemoButton({ onNewMemo }) {
  return (
    <button className="new-memo-button" onClick={onNewMemo}>
      ➕ 새 메모
    </button>
  );
}

export default NewMemoButton;

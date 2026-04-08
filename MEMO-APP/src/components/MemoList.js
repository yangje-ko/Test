import React from 'react';
import MemoItem from './MemoItem';
import './MemoList.css';

function MemoList({ memos, editingId, onEdit, onSave, onDelete }) {
  if (memos.length === 0) {
    return (
      <div className="empty-state">
        <p>메모가 없습니다. 새 메모를 만들어보세요! 📝</p>
      </div>
    );
  }

  return (
    <div className="memo-list">
      {memos.map((memo) => (
        <MemoItem
          key={memo.id}
          memo={memo}
          isEditing={editingId === memo.id}
          onEdit={onEdit}
          onSave={onSave}
          onDelete={onDelete}
        />
      ))}
    </div>
  );
}

export default MemoList;

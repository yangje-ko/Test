import React, { useState, useEffect, useRef } from 'react';
import './MemoItem.css';

function MemoItem({ memo, isEditing, onEdit, onSave, onDelete }) {
  const [title, setTitle] = useState(memo.title);
  const [content, setContent] = useState(memo.content);
  const titleInputRef = useRef(null);

  // 수정 모드로 전환될 때 제목 입력 필드에 포커스
  useEffect(() => {
    if (isEditing && titleInputRef.current) {
      titleInputRef.current.focus();
    }
  }, [isEditing]);

  // 메모가 변경되면 상태 업데이트
  useEffect(() => {
    setTitle(memo.title);
    setContent(memo.content);
  }, [memo]);

  const handleSave = () => {
    if (title.trim() || content.trim()) {
      onSave(memo.id, title.trim(), content.trim());
    }
  };

  const handleCancel = () => {
    setTitle(memo.title);
    setContent(memo.content);
    onSave(memo.id, memo.title, memo.content);
  };

  const formatDate = (dateString) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleString('ko-KR', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  if (isEditing) {
    return (
      <div className="memo-item editing">
        <div className="memo-header">
          <input
            ref={titleInputRef}
            type="text"
            className="memo-title-input"
            placeholder="제목을 입력하세요..."
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
        </div>
        <textarea
          className="memo-content-input"
          placeholder="내용을 입력하세요..."
          value={content}
          onChange={(e) => setContent(e.target.value)}
          rows="8"
        />
        <div className="memo-actions">
          <button className="save-button" onClick={handleSave}>
            💾 저장
          </button>
          <button className="cancel-button" onClick={handleCancel}>
            취소
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="memo-item">
      <div className="memo-header">
        <h3 className="memo-title">{memo.title || '(제목 없음)'}</h3>
        <div className="memo-meta">
          {memo.updatedAt ? (
            <span className="memo-date">수정: {formatDate(memo.updatedAt)}</span>
          ) : (
            <span className="memo-date">생성: {formatDate(memo.createdAt)}</span>
          )}
        </div>
      </div>
      <div className="memo-content">{memo.content || '(내용 없음)'}</div>
      <div className="memo-actions">
        <button className="edit-button" onClick={() => onEdit(memo.id)}>
          ✏️ 수정
        </button>
        <button className="delete-button" onClick={() => onDelete(memo.id)}>
          🗑️ 삭제
        </button>
      </div>
    </div>
  );
}

export default MemoItem;

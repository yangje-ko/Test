import React, { useState, useEffect } from 'react';
import './App.css';
import MemoList from './components/MemoList';
import SearchBar from './components/SearchBar';
import NewMemoButton from './components/NewMemoButton';

function App() {
  const [memos, setMemos] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');
  const [editingId, setEditingId] = useState(null);

  // 로컬 스토리지에서 메모 불러오기
  useEffect(() => {
    const savedMemos = localStorage.getItem('memos');
    if (savedMemos) {
      setMemos(JSON.parse(savedMemos));
    }
  }, []);

  // 메모가 변경될 때마다 로컬 스토리지에 저장
  useEffect(() => {
    localStorage.setItem('memos', JSON.stringify(memos));
  }, [memos]);

  // 새 메모 추가
  const handleNewMemo = () => {
    const newMemo = {
      id: Date.now(),
      title: '',
      content: '',
      createdAt: new Date().toISOString(),
    };
    setMemos([newMemo, ...memos]);
    setEditingId(newMemo.id);
  };

  // 메모 수정
  const handleEdit = (id) => {
    setEditingId(id);
  };

  // 메모 저장
  const handleSave = (id, title, content) => {
    setMemos(
      memos.map((memo) =>
        memo.id === id
          ? { ...memo, title, content, updatedAt: new Date().toISOString() }
          : memo
      )
    );
    setEditingId(null);
  };

  // 메모 삭제
  const handleDelete = (id) => {
    setMemos(memos.filter((memo) => memo.id !== id));
    if (editingId === id) {
      setEditingId(null);
    }
  };

  // 검색 필터링
  const filteredMemos = memos.filter((memo) => {
    const query = searchQuery.toLowerCase();
    return (
      memo.title.toLowerCase().includes(query) ||
      memo.content.toLowerCase().includes(query)
    );
  });

  return (
    <div className="App">
      <div className="container">
        <h1 className="app-title">📝 MEMO APP</h1>
        <div className="controls">
          <NewMemoButton onNewMemo={handleNewMemo} />
          <SearchBar searchQuery={searchQuery} onSearchChange={setSearchQuery} />
        </div>
        <MemoList
          memos={filteredMemos}
          editingId={editingId}
          onEdit={handleEdit}
          onSave={handleSave}
          onDelete={handleDelete}
        />
      </div>
    </div>
  );
}

export default App;

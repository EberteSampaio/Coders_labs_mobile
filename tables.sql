--Algumas colunas ou tabelas podem ser criadas, modificadas e deletadas futuramente,

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,  
    name TEXT NOT NULL,                    
    email TEXT UNIQUE NOT NULL,            
    role TEXT NOT NULL DEFAULT 'cliente',  
    password TEXT NOT NULL,                
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE tickets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,      
    title TEXT NOT NULL,                       
    description TEXT NOT NULL,                 
    priority TEXT NOT NULL DEFAULT 'media',    
    status TEXT NOT NULL DEFAULT 'aberto',     
    category TEXT,                            
    created_by INTEGER NOT NULL,               
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE ticket_followups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticket_id INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_by INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE ticket_attachments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticket_id INTEGER NOT NULL,
    file_name TEXT NOT NULL,
    file_path TEXT NOT NULL,
    uploaded_by INTEGER NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE CASCADE
);


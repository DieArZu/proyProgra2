	create database reservasdatabaseweb;
	use reservasdatabaseweb;

	CREATE TABLE Usuarios (
		id INT AUTO_INCREMENT PRIMARY KEY,
		nombre VARCHAR(50) NOT NULL UNIQUE,
		email VARCHAR(100) NOT NULL,
		password VARCHAR(255) NOT NULL
		);

CREATE TABLE Eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    fecha DATE,
    foto VARCHAR(255),
    ubicacion VARCHAR(255),
    total_entradas INT,
    entradas_disponibles INT
);

CREATE TABLE Reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    evento_id INT,
    cantidad INT,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(id)
);

INSERT INTO Usuarios (nombre, email, password) VALUES 
('DAZ', 'daz@daz.com', '111');

INSERT INTO Eventos (nombre, descripcion, fecha, foto, ubicacion, entradas_disponibles) VALUES 
('Concierto de Rock', 'Un concierto espectacular de rock en vivo.', '2024-12-15', 'https://i.blogs.es/503a9a/fotografia-concierto/1366_2000.webp', 'Estadio Nacional', 500),
('Obra de Teatro', 'Una obra teatral clásica con actores reconocidos.', '2024-11-25', 'https://alternativalteatral.com/wp-content/uploads/las-mejores-obras-de-teatro-recomendadas-para-el-2023-descubre-que-espectaculos-no-puedes-perderte-1024x683.webp', 'Teatro Principal', 200),
('Feria de Ciencia', 'Exposición de proyectos y descubrimientos científicos.', '2024-11-18', 'https://agenciasanluis.com/wp-content/uploads/2023/05/feria-de-ciencias.jpeg', 'Centro de Convenciones', 300);

INSERT INTO Reservas (usuario_id, evento_id, cantidad) VALUES 
(1, 1, 2),  -- 
(1, 2, 3),  -- 
(1, 3, 1);  -- 



SELECT * FROM Eventos;

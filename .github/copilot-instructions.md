# CS-IMC-TPBDD - AI Coding Agent Instructions

## Project Overview
This is an educational database practical work comparing relational (Azure SQL) and graph (Neo4j) paradigms using IMDB movie data. Students implement queries and data transformations between both systems.

## Architecture & Data Flow
- **Source**: Azure SQL Database with IMDB data (tables: `tArtist`, `tFilm`, `tFilmGenre`, `tGenre`, `tJob`)
- **Target**: Neo4j graph database with nodes for Artists and Films, relationships for jobs (acted_in, directed, produced, composed)
- **ETL**: Python scripts using `pyodbc` (SQL Server) and `py2neo` (Neo4j) for data export

## Key Components
- `export-neo4j.py`: Bulk data export from SQL to Neo4j (incomplete - students complete the node/relationship creation)
- `pyodbc-py2neo-test.py`: Connection validation script
- `requetes.sql`: SQL exercises for relational queries
- Cypher queries implemented directly in Neo4j browser (not in repo)

## Development Workflow
1. **Setup**: Download `.env` file with connection credentials from instructor
2. **Test**: Run `python3 pyodbc-py2neo-test.py` to verify database connections
3. **Export**: Complete and run `export-neo4j.py` to populate Neo4j (uses batch processing for performance)
4. **Query**: Implement SQL queries in `requetes.sql`, Cypher queries in Neo4j browser

## Connection Configuration
Environment variables in `.env`:
```bash
TPBDD_SERVER=tpbdd-sqlserver.database.windows.net
TPBDD_DB=tpbdd-sql
TPBDD_USERNAME=sqlread-user
TPBDD_PASSWORD=<provided>
ODBC_DRIVER={ODBC Driver 18 for SQL Server}

TPBDD_NEO4J_SERVER=<bolt://...>
TPBDD_NEO4J_USER=neo4j
TPBDD_NEO4J_PASSWORD=<neo4j-password>
```

## Coding Patterns
- **Batch Processing**: Use `BATCH_SIZE = 10000` for large data operations (see `export-neo4j.py`)
- **Node Creation**: Use `py2neo.data.Node(label, **properties)` for Neo4j nodes
- **Relationships**: Use `py2neo.bulk.create_relationships()` with tuples `(start_id, props, end_id)`
- **Relationship Types**: Convert spaces to underscores (e.g., "acted in" → "acted_in")
- **Indexing**: Create indexes on ID properties for performance: `CREATE INDEX ON :Label(idProperty)`

## Database Schema
- **Artists**: `idArtist`, `primaryName`, `birthYear`
- **Films**: `idFilm`, `primaryTitle`, `startYear`, `runtimeMinutes`
- **Jobs**: `idArtist`, `category` (acted in/directed/produced/composed), `idFilm`

## Common Issues
- Neo4j Sandbox expires after 3 days - recreate when needed
- Use absolute paths for file operations
- Handle connection timeouts with retry logic
- French comments/documentation throughout codebase

## Testing & Validation
- Run connection test script before any database operations
- Verify data counts match between SQL and Neo4j after export
- Use Neo4j browser for Cypher query development and debugging</content>
<parameter name="filePath">/workspaces/CS-IMC-TPBDD/.github/copilot-instructions.md
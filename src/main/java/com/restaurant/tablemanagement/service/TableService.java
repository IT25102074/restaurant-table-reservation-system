package com.restaurant.tablemanagement.service;

import com.restaurant.tablemanagement.model.RestaurantTable;
import com.restaurant.tablemanagement.model.TableStatus;
import com.restaurant.tablemanagement.model.TableType;
import jakarta.annotation.PostConstruct;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Optional;

@Service
public class TableService {

    private final JdbcTemplate jdbcTemplate;

    private final RowMapper<RestaurantTable> rowMapper = (rs, rowNum) -> new RestaurantTable(
            rs.getLong("id"),
            rs.getString("table_code"),
            rs.getInt("capacity"),
            TableType.valueOf(rs.getString("table_type")),
            TableStatus.valueOf(rs.getString("table_status"))
    );

    public TableService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @PostConstruct
    public void init() {
        jdbcTemplate.execute("""
                CREATE TABLE IF NOT EXISTS restaurant_tables (
                    id BIGINT PRIMARY KEY AUTO_INCREMENT,
                    table_code VARCHAR(100) NOT NULL,
                    capacity INT NOT NULL,
                    table_type VARCHAR(20) NOT NULL,
                    table_status VARCHAR(20) NOT NULL
                )
                """);
    }

    public List<RestaurantTable> findAll() {
        return jdbcTemplate.query(
                "SELECT id, table_code, capacity, table_type, table_status FROM restaurant_tables ORDER BY id",
                rowMapper
        );
    }

    public Optional<RestaurantTable> findById(Long id) {
        List<RestaurantTable> result = jdbcTemplate.query(
                "SELECT id, table_code, capacity, table_type, table_status FROM restaurant_tables WHERE id = ?",
                rowMapper,
                id
        );
        return result.stream().findFirst();
    }

    public RestaurantTable create(RestaurantTable table) {
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO restaurant_tables (table_code, capacity, table_type, table_status) VALUES (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, table.getTableCode());
            ps.setInt(2, table.getCapacity());
            ps.setString(3, table.getType().name());
            ps.setString(4, table.getStatus().name());
            return ps;
        }, keyHolder);

        Number generatedId = keyHolder.getKey();
        if (generatedId == null) {
            throw new IllegalStateException("Failed to create table: missing generated id");
        }
        return findById(generatedId.longValue())
                .orElseThrow(() -> new IllegalStateException("Failed to create table"));
    }

    public Optional<RestaurantTable> update(Long id, RestaurantTable updatedTable) {
        int updatedCount = jdbcTemplate.update(
                "UPDATE restaurant_tables SET table_code = ?, capacity = ?, table_type = ?, table_status = ? WHERE id = ?",
                updatedTable.getTableCode(),
                updatedTable.getCapacity(),
                updatedTable.getType().name(),
                updatedTable.getStatus().name(),
                id
        );

        if (updatedCount == 0) {
            return Optional.empty();
        }

        return findById(id);
    }

    public boolean delete(Long id) {
        return jdbcTemplate.update("DELETE FROM restaurant_tables WHERE id = ?", id) > 0;
    }

    public long totalTables() {
        return countByQuery("SELECT COUNT(*) FROM restaurant_tables");
    }

    public long availableTables() {
        return countByQuery("SELECT COUNT(*) FROM restaurant_tables WHERE table_status = 'AVAILABLE'");
    }

    public long reservedTables() {
        return countByQuery("SELECT COUNT(*) FROM restaurant_tables WHERE table_status = 'RESERVED'");
    }

    public long indoorTables() {
        return countByQuery("SELECT COUNT(*) FROM restaurant_tables WHERE table_type = 'INDOOR'");
    }

    public long outdoorTables() {
        return countByQuery("SELECT COUNT(*) FROM restaurant_tables WHERE table_type = 'OUTDOOR'");
    }

    private long countByQuery(String sql) {
        Long count = jdbcTemplate.queryForObject(sql, Long.class);
        return count == null ? 0L : count;
    }
}
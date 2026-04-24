package com.restaurant.tablemanagement.model;

public class RestaurantTable {

    private Long id;
    private String tableCode;
    private Integer capacity;
    private TableType type;
    private TableStatus status;

    public RestaurantTable() {
    }

    public RestaurantTable(Long id, String tableCode, Integer capacity, TableType type, TableStatus status) {
        this.id = id;
        this.tableCode = tableCode;
        this.capacity = capacity;
        this.type = type;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTableCode() {
        return tableCode;
    }

    public void setTableCode(String tableCode) {
        this.tableCode = tableCode;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public TableType getType() {
        return type;
    }

    public void setType(TableType type) {
        this.type = type;
    }

    public TableStatus getStatus() {
        return status;
    }

    public void setStatus(TableStatus status) {
        this.status = status;
    }
}

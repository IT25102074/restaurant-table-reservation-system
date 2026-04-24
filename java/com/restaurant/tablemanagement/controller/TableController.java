package com.restaurant.tablemanagement.controller;

import com.restaurant.tablemanagement.model.RestaurantTable;
import com.restaurant.tablemanagement.model.TableForm;
import com.restaurant.tablemanagement.model.TableStatus;
import com.restaurant.tablemanagement.model.TableType;
import com.restaurant.tablemanagement.service.TableService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping
public class TableController {

    private final TableService tableService;

    public TableController(TableService tableService) {
        this.tableService = tableService;
    }

    @GetMapping("/")
    public String dashboard(Model model) {
        List<RestaurantTable> tables = tableService.findAll();
        model.addAttribute("tables", tables);
        model.addAttribute("totalTables", tableService.totalTables());
        model.addAttribute("availableTables", tableService.availableTables());
        model.addAttribute("reservedTables", tableService.reservedTables());
        model.addAttribute("indoorTables", tableService.indoorTables());
        model.addAttribute("outdoorTables", tableService.outdoorTables());
        return "dashboard";
    }

    @GetMapping("/tables")
    public String listTables(Model model) {
        model.addAttribute("tables", tableService.findAll());
        return "tables";
    }

    @GetMapping("/tables/add")
    public String addTablePage(Model model) {
        if (!model.containsAttribute("tableForm")) {
            model.addAttribute("tableForm", new TableForm());
        }
        model.addAttribute("isEdit", false);
        return "table-form";
    }

    @PostMapping("/tables")
    public String createTable(@Valid @ModelAttribute("tableForm") TableForm tableForm,
                              BindingResult bindingResult,
                              RedirectAttributes redirectAttributes,
                              Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "table-form";
        }

        RestaurantTable table = mapToEntity(tableForm);
        tableService.create(table);
        redirectAttributes.addFlashAttribute("message", "Table created successfully.");
        return "redirect:/tables";
    }

    @GetMapping("/tables/{id}/edit")
    public String editTablePage(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        return tableService.findById(id)
                .map(table -> {
                    if (!model.containsAttribute("tableForm")) {
                        model.addAttribute("tableForm", mapToForm(table));
                    }
                    model.addAttribute("tableId", id);
                    model.addAttribute("isEdit", true);
                    return "table-form";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Table not found.");
                    return "redirect:/tables";
                });
    }

    @PostMapping("/tables/{id}")
    public String updateTable(@PathVariable Long id,
                              @Valid @ModelAttribute("tableForm") TableForm tableForm,
                              BindingResult bindingResult,
                              RedirectAttributes redirectAttributes,
                              Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("tableId", id);
            model.addAttribute("isEdit", true);
            return "table-form";
        }

        RestaurantTable updatedTable = mapToEntity(tableForm);
        boolean updated = tableService.update(id, updatedTable).isPresent();

        if (!updated) {
            redirectAttributes.addFlashAttribute("error", "Table not found.");
            return "redirect:/tables";
        }

        redirectAttributes.addFlashAttribute("message", "Table updated successfully.");
        return "redirect:/tables";
    }

    @PostMapping("/tables/{id}/delete")
    public String deleteTable(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (tableService.delete(id)) {
            redirectAttributes.addFlashAttribute("message", "Table removed successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Table not found.");
        }
        return "redirect:/tables";
    }

    @ModelAttribute("tableTypes")
    public TableType[] tableTypes() {
        return TableType.values();
    }

    @ModelAttribute("tableStatuses")
    public TableStatus[] tableStatuses() {
        return TableStatus.values();
    }

    private RestaurantTable mapToEntity(TableForm form) {
        RestaurantTable table = new RestaurantTable();
        table.setTableCode(form.getTableCode().trim());
        table.setCapacity(form.getCapacity());
        table.setType(form.getType());
        table.setStatus(form.getStatus());
        return table;
    }

    private TableForm mapToForm(RestaurantTable table) {
        TableForm form = new TableForm();
        form.setTableCode(table.getTableCode());
        form.setCapacity(table.getCapacity());
        form.setType(table.getType());
        form.setStatus(table.getStatus());
        return form;
    }
}

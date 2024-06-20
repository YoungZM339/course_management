package com.youngzm.course_management.controller;

import com.youngzm.course_management.dto.AssignRequest;
import com.youngzm.course_management.service.AssignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/api/assign")
public class AssignController {
    @Autowired
    private AssignService assignService;

    @PostMapping
    public ResponseEntity<String> assignCourseToTeacher(@RequestBody AssignRequest request) {
        try {
            assignService.assignCourseToTeacher(request);
            return ResponseEntity.ok("Course assigned to teacher successfully.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred.");
        }
    }
}

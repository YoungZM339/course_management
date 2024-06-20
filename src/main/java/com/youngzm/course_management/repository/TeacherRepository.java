package com.youngzm.course_management.repository;

import com.youngzm.course_management.entity.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TeacherRepository extends JpaRepository<Teacher, Long> {
}

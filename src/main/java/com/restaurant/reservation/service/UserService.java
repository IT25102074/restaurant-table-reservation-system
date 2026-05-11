package com.restaurant.reservation.service;

import com.restaurant.reservation.model.User;
import java.util.List;

public interface UserService {

	void saveUser(User user);

	User findByUsername(String username);

	List<User> findAllUsers();

	void deleteUser(Long id);

	User findById(Long id);

	void updateUser(User user);
}
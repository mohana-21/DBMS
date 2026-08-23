# E-Commerce Order Management System – RDBMS Project

## Project Overview

The E-Commerce Order Management System is a database-focused project designed to manage customers, products, orders, payments, inventory, and other order-related activities in an e-commerce environment.

This project demonstrates practical implementation of RDBMS concepts, including ER modeling, database normalization, SQL queries, NoSQL concepts, PL/SQL programming, database constraints, reporting, and database testing.

## Objectives

- Design a structured database for an e-commerce platform.
- Manage customer, product, seller, inventory, and order information.
- Establish relationships between different entities using an ER model.
- Apply normalization to reduce data redundancy.
- Implement primary key, foreign key, unique, check, and not-null constraints.
- Perform CRUD operations using SQL.
- Implement advanced SQL queries for data analysis and reporting.
- Use PL/SQL for procedures, functions, triggers, and business logic.
- Explore NoSQL concepts for handling flexible and unstructured data.
- Test database operations for accuracy and consistency.

## 🏗️ System Modules

### 1. Customer Management

- Store customer details.
- Manage customer registration information.
- Retrieve customer order history.
- Maintain customer contact details.

### 2. Product Management

- Add and update product information.
- Maintain product categories and pricing.
- Track product availability.
- Manage seller-product relationships.

### 3. Inventory Management

- Track available product quantities.
- Update stock based on orders.
- Identify available and unavailable products.
- Generate inventory status reports.

### 4. Order Management

- Create and manage customer orders.
- Store order date, quantity, and total amount.
- Maintain order details.
- Track order status.
- Generate customer order history.

### 5. Payment Management

- Maintain payment information.
- Track payment status and transaction details.
- Associate payments with customer orders.

### 6. Reporting and Analysis

Generate reports such as:

- Customer order history
- Product sales report
- Inventory status report
- Top-selling products
- Customer purchase summary
- Order status report
- Revenue summary

## Database Design

The system uses an Entity Relationship (ER) Model to represent relationships between major entities.

### Main Entities

- Customer
- Seller
- Product
- Category
- Inventory
- Orders
- Order_Details
- Payment

### Example Relationships

```text
Customer
   │
   └── places ──> Orders
                    │
                    └── contains ──> Order_Details
                                      │
                                      └── refers to ──> Product
                                                         │
                              ┌──────────────────────────┤
                              │                          │
                           Seller                    Inventory

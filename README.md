# OpenCart Automation Suite

This project automates the login process and basic product-related actions on the OpenCart demo site using the Robot Framework and SeleniumLibrary.

## Features

- Automates login to the OpenCart demo portal.
- Searches and adds specified products to the cart.
- Utilizes the SeleniumLibrary for web automation.
- Includes a structured approach with test case definitions, variables, and suite setup/teardown.

## Prerequisites

Before running the tests, ensure you have the following installed:

1. **Python**: Version 3.6 or later.
2. **Robot Framework**: Install using `pip install robotframework`.
3. **SeleniumLibrary**: Install using `pip install robotframework-seleniumlibrary`.
4. **WebDriver**: Install the appropriate driver for your browser (e.g., ChromeDriver for Google Chrome).

## File Structure

- `test.robot`: Contains the test cases and setup for automation.
- **Libraries**: SeleniumLibrary is used for browser automation.
- **Variables**:
  - `${products}`: A list of products for testing.
  - `${MAX_LIMIT}`: A variable demonstrating simple arithmetic in Robot Framework.

## Test Case Overview

### Test Case: `test`

1. **GIVEN**: Open the browser and log in to the OpenCart portal.
2. **WHEN**: Perform product search and add specified products to the cart.
3. **THEN**: Verify the product-related actions were successful.

## How to Run

1. Open a terminal in the directory containing `test.robot`.
2. Execute the following command:

   ```bash
   robot tests/test.robot

# Amazon Product Search Automation

This project automates the process of searching for wristwatches on Amazon, selecting a specific product, and interacting with various elements on the page using the Robot Framework and SeleniumLibrary.

## Features

- Searches for wristwatches on Amazon.
- Interacts with elements like search bar, product list, and filters.
- Captures details about a specific product for further processing.

## Test Case Overview

### Assignment 2: Search for Wrist Watches

1. **Navigate** to the Amazon India website.
2. **Search** for the product defined by `${PRODUCT}`.
3. **Interact** with elements such as:
   - Search bar (`id:twotabsearchtextbox`)
   - Submit button (`id:nav-search-submit-button`)
   - Product filters and results.
4. **Select** the 5th product from the search results

## How to Run
```bash
   robot tests/assignment.robot

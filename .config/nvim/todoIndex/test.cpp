#include <iostream>
#include <vector>
#include <string>

// TODO: Refactor this function to use std::string_view
void printTodos(const std::vector<std::string>& todos) {
    for (const auto& todo : todos) {
        std::cout << "- " << todo << std::endl;
    }
}

/*
TODO: Add error handling for empty input
      and validate the input format.
*/

std::vector<std::string> parseInput(int argc, char* argv[]) {
    std::vector<std::string> todos;
    for (int i = 1; i < argc; ++i) {
        todos.push_back(argv[i]);
    }
    return todos;
}

int main(int argc, char* argv[]) {
    // TODO: Support reading from a file
    std::vector<std::string> todos = parseInput(argc, argv);

    // TODO: Remove duplicate TODOs
    std::cout << "Your TODOs:" << std::endl;
    printTodos(todos);

    // TODO: Add interactive mode ----------------------------------------------
    // TODO: Save TODOs to disk

    // Example hardcoded TODOs for testing
    std::vector<std::string> hardcoded = {
        "Buy groceries", // TODO: Add categories
        "Finish project", // TODO: Set deadlines
        "Call Alice", // TODO: Add phone number validation
        "Read a book" // TODO: Suggest book titles
    };

    std::cout << "\nHardcoded TODOs:" << std::endl;
    printTodos(hardcoded);

    // TODO: Implement search functionality
    // TODO: Allow marking TODOs as done

    return 0;
}

// TODO: Write unit tests for parseInput
// TODO: Document all functions
```


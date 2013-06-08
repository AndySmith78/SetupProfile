Feature: Create Symlinks
  @create_symlinks
  Scenario: Symlinks should be created for files in a directory
    Given there are files in a directory
    When I run the create symlink command
    Then I should have symlinks created for each file in the directory

  @create_symlinks
  Scenario: Should create a symlink for your file even if symlinks already exists
    Given there is a folder with symlinks already created
    When I run the create symlink command with folder 3
    Then the existing symlinks should be removed and created for my directory

Feature: Create Symlinks

  Scenario: Symlinks should be created for files in a directory
    Given there are files in a directory
    When I run the symlink create command
    Then I should have symlinks created for each file in the directory

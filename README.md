# Pocket Recipe

This is the mobile version of the same recipe app that I created for the web. I initially had the same concept for the mobile version but during development, and after learning more about what I can do with the Spoonacular API, I decided to push it further and make it much more helpful. This is a more interactive version of the app and I am very proud of it. It is almost complete, I'm just in the works of a bug that I'm trying to fix. 

## How it Works

The interface is simple. The main page explains how the app works and explains to the user how to use the app. You type in the list of ingredients that you have in the text box, then press "Get Recipes." You are then taken to a page where it shows the list of possible dishes you can make using the ingredients you entered. When you select a dish, a dialog box appears with the cooking instructions and the recipes that you will need. Take a look below at how it works.

### Main Page

This is the first page that appears when you open the app. It explains the steps on how the app works, and it's also the page where the user inputs their ingredients to get the recipes.

<img src="https://github.com/user-attachments/assets/aec46910-6bd6-4d3d-9015-880b302b4c1c" alt="1" width="270" height="572"/>

#### Getting Recipes

At the bottom of the main page, there's the text box and the button that the user will interact with. They type their ingredients in the text box, then press the "Get Recipes!" button to get the recipes they want, based on the ingredients they entered.

<img src="https://github.com/user-attachments/assets/ea8744ff-ba67-457f-8f50-d9c41c75b597" alt="2" width="270" height="572"/>

<img src="https://github.com/user-attachments/assets/0afcf9e3-8a7d-4063-80d4-9537b30889bc" alt="3" width="270" height="572"/>

### Second Page

After the user clicks on the "Get Recipes!" button, they are taken to the second page. This page will list the possible dishes that the user can make, with the ingredients that they entered in the ingredients box in the first page. 

<img src="https://github.com/user-attachments/assets/b9c260fa-914c-49ed-922c-2e7b8c148f79" alt="4" width="270" height="572"/>

### Third Page

The third page will show more details about the dish that the user slected. It will show the recipe name, how long it takes to prepare and the servings, along with an image. More results will show if there are more viariants of this dish.

<img src="https://github.com/user-attachments/assets/5fad4d0a-1d8b-4261-9d6e-e504ae4ce5e0" alt="5" width="270" height="572"/>

### Recipe Dialog Box

When the user taps the "Full Recipe" button, a dialog box will appear that shows the actual recipe of the dish. This will show the ingredients needed, and then it will show the prep and cooking instructions after that. A close button is in the dialog box if the user wants to exit, and select another variant of that dish.

<img src="https://github.com/user-attachments/assets/489d4f4c-8fd7-4aed-9a15-1055e4c8f504" alt="7" width="270" height="572"/>

## What is left

There is a bug with this app that when you tpye in your inggredients, find a recipe in the list, and select it, sometimes you get an empty page. This is due to Spoonacular having empty data for that particular dish. What would be nice would be to show an error message indicating that there's not information for that dish, or better yet, not list the dish at all. This is in the works.

If someone enters ingredients that are, well...not ingredients, then the second page will just show ab empty page. What would I would like to do for this is to show an error message instead, indicating that recipes cannot be found with those ingredients. 





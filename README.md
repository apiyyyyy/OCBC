# OCBC

Im making this app using a simple MVC, and using storyboard because this app only have 4 view and i dont think using such as MVVM and Xib is a good idea because its a simple app.

how i implement MVC is a little bit different. 

Im making 1 folder of "Service" which contain :
- APIService -> this file contain my get and push service that i use for the whole app
- RESTConfig -> i make this single struct because for custom header it need its own URLRequest, so i just make my own requestConfig
  -> i also make my own StatusCode Struct, this is for i can work easier with the date and the return from json. and i need something to pass from one controller to another and this StatusCode its just make it easier

- Model : this is for data modeling that i use to fetch the data from json into its own variable. this makes easier to use the data when i can just call the struct and it can provide the data that i need 
- Page: this page is contain every page controller that this app use, each controller page have 2 individual folder, which is :
	- Controller -> this is where i display all the ui related, no logic is being use in this controller, so everything related to the ui i put it in here
	- PageModel -> every Controller have is own PageModel, it contains the logic that required for the apps can work properly. like logic service to called the json i put it here in PageModel, and when i want to use it    i can just called it from my Controller

  - Global : this class its contain my every reusable code, so i dont have to make a new one over and over again. its not just contain global var but also contain global func.

Thank you. 

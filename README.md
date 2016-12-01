#Instructions
=====
#R
==
To launch code in R, please download and use R Studio [here](https://www.rstudio.com/).
You can then open the file `mod.r` and select the code to execute.

#NodeJS
==
To execute NodeJS code, please download NodeJS [here](http://nodejs.org).
Being on the `mod` folder, you can call `node model.js` to see the results.

If custom results needed, open a NodeJS console, and type the following:
```
> .load model.js
```
while on the correct folder (`mod`).

If you can't install nodejs, or want to run the code in your browser (Chrome, Safari), you can replace the first two lines of the file `model.js`by the entire graph.
```
const states = {<paste here>};
```

To do so, open the file `graph.json`, select all and paste replacing
```
const fs = require('fs');
const states = JSON.parse(fs.readFileSync('./graph.json'));
```

You can then copy the whole file and paste it on the developer console of your browser (F12 key).

You can then call the functions 

*`estimate(max_steps, desired_state, number_of_tests)`

*`estimate_time(desired_state, number_of_tests)`

*`estimate_x_before_y(y, x, number_of_tests)`

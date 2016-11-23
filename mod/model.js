const fs = require('fs');
const states = JSON.parse(fs.readFileSync('./graph.json'));

const n = 1000000000;

var exec = {
	currentState: states[3],
	history: [4]
};

function getState(id){
	for(var s of states){
		if(s.id === id){
			return s;
		}
	}
	console.error('NO SUCH STATE', id);
	return null;
}

function getProbs(state){
	probs = [];
	last_val=0;
	for(var p of state.links){
		probs.push({
			id: p.id,
			from: last_val,
			to: (n * p.prob) + last_val
		});
		last_val = (n * p.prob) + last_val;
	}
	return probs;
};

function step(log){
	var probs = getProbs(exec.currentState);
	var r = Math.random() * n;
	for(var p of probs){
		if(r >= p.from && r < p.to){
			exec.currentState.passes = 
				exec.currentState.passes ? exec.currentState.passes+1 : 1; 
			exec.currentState = getState(p.id);
			exec.history.push(exec.currentState.id);
			if(log){
				console.log('New state is', exec.currentState.id);
				console.log('History is', exec.history);
			}
			break;
		}
	}
};

function init(){
	exec.currentState = states[3];
	exec.history = [4]
}

function run(iterations, log){
	init();
	for(var i = 0; i < iterations; i++){
		step(log);
	}
	console.log('Final History', JSON.stringify(exec.history));
	return exec.history;
}

function estimate(n, final_state, iterations){
	init();
	var histories = [];
	for(var i =0; i < iterations; i++){
		histories.push(run(n));
		init();
	}
	var count = 0;
	for(var h of histories){
		if(h[h.length -1] === final_state){
			count+=1;
		}
	}
	console.log('Estimated:', count, count/iterations);
}

function estimate_time(desired_state, iterations){
	init();
	var n = [];
	var res = 0;
	for(var i = 0; i < iterations; i++){
		n[i] = 0;
		while(exec.currentState.id != desired_state){
			n[i]++;
			step();
		}
		init();
	}
	for(var t of n){
		res += t;
	}
	console.log(`Estimated time to enter ${desired_state}`, res/iterations);
}

function estimate_x_before_y(y,x, iterations){
	var runs = [];
	for(var i = 0;  i < iterations; i++){
		init();
		while(exec.currentState.id != y){
			step();
		}
		runs.push(exec.history);
	}
	var entered_x = 0;
	for(var h of runs){
		if(h.indexOf(x) > -1){
			entered_x++;
		}
	}
	console.log(`Prob to enter ${x} before ${y} is`, entered_x/iterations);
}
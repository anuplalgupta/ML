
//<![CDATA[

// a few things don't have var in front of them - they update already existing variables the game needs
lanesSide = 1;
patchesAhead = 10;
patchesBehind = 0;
trainIterations = 10000;

var num_inputs = (lanesSide * 2 + 1) * (patchesAhead + patchesBehind);
var num_actions = 5;
var temporal_window = 10;
var network_size = num_inputs * temporal_window + num_actions * temporal_window + num_inputs;

var layer_defs = [];
layer_defs.push({
    type: 'input',
    out_sx: 1,
    out_sy: 1,
    out_depth: network_size
});
layer_defs.push({
    type: 'fc',
    num_neurons: 1,
    activation: 'relu'
});
layer_defs.push({
    type: 'regression',
    num_neurons: num_actions
});

var tdtrainer_options = {
    learning_rate: 0.001,
    momentum: 1.0,
    batch_size: 64,
    l2_decay: 0.01
};

var opt = {};
opt.temporal_window = temporal_window;
opt.experience_size = 3000;
opt.start_learn_threshold = 500;
opt.gamma = 0.7;
opt.learning_steps_total = 10000;
opt.learning_steps_burnin = 1000;
opt.epsilon_min = 0.0;
opt.epsilon_test_time = 0.0;
opt.layer_defs = layer_defs;
opt.tdtrainer_options = tdtrainer_options;

brain = new deepqlearn.Brain(num_inputs, num_actions, opt);

learn = function (state, lastReward) {
    brain.backward(lastReward);
    var action = brain.forward(state);

    draw_net();
    draw_stats();

    return action;
}

//]]>
    
/*###########*/
if (brain) {
brain.value_net.fromJSON({"layers":[{"out_depth":56,"out_sx":1,"out_sy":1,"layer_type":"input"},{"out_depth":1,"out_sx":1,"out_sy":1,"layer_type":"fc","num_inputs":56,"l1_decay_mul":0,"l2_decay_mul":1,"filters":[{"sx":1,"sy":1,"depth":56,"w":{"0":-0.14824348479790994,"1":0.11369035383570325,"2":-0.06147366580559953,"3":0.0861669994371609,"4":-0.1799476834540768,"5":-0.09288085145691,"6":0.06982052745476956,"7":0.18895001356020572,"8":0.11042564366702576,"9":0.17678834248542652,"10":0.20388826299364848,"11":0.2126888810399337,"12":0.15791214027078496,"13":0.08249678795693983,"14":0.10063328442395122,"15":-0.10433730640209987,"16":0.03936405376338315,"17":0.07091222759333494,"18":0.13550914853815893,"19":-0.1694120327895736,"20":0.3160016788654158,"21":-0.20990521504743928,"22":0.11621222439582393,"23":-0.29621829145765033,"24":-0.050836733983990995,"25":0.11199025699029876,"26":-0.12448405126850381,"27":-0.046654015699311484,"28":0.00114038248470043,"29":0.0335556482809487,"30":-0.0648482084149372,"31":0.13971278487922006,"32":0.003244888904602203,"33":0.12014760660358474,"34":0.02877082282597167,"35":-0.1628630580951093,"36":-0.03273771004593375,"37":0.09613400918327364,"38":-0.03636969506128284,"39":0.08896652040125738,"40":-0.18630035644406076,"41":-0.03303394583480511,"42":0.017680014180019736,"43":-0.05867796283548407,"44":0.19513323914563296,"45":-0.009887664058266455,"46":-0.14456333268178995,"47":-0.19455817868014974,"48":0.07525913291466406,"49":-0.2684171185625029,"50":-0.05041417366810788,"51":0.039869829928661775,"52":0.04101525406335312,"53":-0.19247633517988208,"54":0.1434853641457892,"55":0.13043086257304895}}],"biases":{"sx":1,"sy":1,"depth":1,"w":{"0":0.1}}},{"out_depth":1,"out_sx":1,"out_sy":1,"layer_type":"relu"},{"out_depth":6,"out_sx":1,"out_sy":1,"layer_type":"fc","num_inputs":1,"l1_decay_mul":0,"l2_decay_mul":1,"filters":[{"sx":1,"sy":1,"depth":1,"w":{"0":-0.16168462360224634}},{"sx":1,"sy":1,"depth":1,"w":{"0":-0.09637958186609999}},{"sx":1,"sy":1,"depth":1,"w":{"0":-1.128427170130855}},{"sx":1,"sy":1,"depth":1,"w":{"0":-0.3741690226633851}},{"sx":1,"sy":1,"depth":1,"w":{"0":0.12359383672433007}},{"sx":1,"sy":1,"depth":1,"w":{"0":-0.42798943444051707}}],"biases":{"sx":1,"sy":1,"depth":6,"w":{"0":0,"1":0,"2":0,"3":0,"4":0,"5":0}}},{"out_depth":6,"out_sx":1,"out_sy":1,"layer_type":"regression","num_inputs":6}]});
}
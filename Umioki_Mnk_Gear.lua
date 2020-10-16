function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Counter','Acc','Malignance')--,'FullAcc', 'Malignance')
    state.WeaponskillMode:options('Match','Normal', 'Counter', 'Acc','Malignance')--, 'FullAcc', 'Malignance')
    state.HybridMode:options('Normal', 'PDT','PDTOnly')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	--state.Weapons:options('Spharai',','ProcClub','Barehanded','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana')
	state.Weapons:options('Verethragna','Spharai','Staff')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}}}
	sets.precast.JA['Boost'] = {} --hands="Anchorite's Gloves +1"
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +3"}
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +3"}
	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +3"}

	sets.precast.JA['Chi Blast'] = {head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
	legs={ name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+16','Accuracy+8','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    feet={ name="Herculean Boots", augments={'"Fast Cast"+1','Accuracy+21','"Treasure Hunter"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},}
	
	sets.precast.JA['Chakra'] = {
		hands="Hesychast's Gloves +3",
		legs="Hes. Hose +3",feet="Anch. Gaiters +3"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
		
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	
	sets.precast.FC = {
    ammo="Staunch Tathlum +1",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    neck="Voltsurge Torque",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Fast Cast"+10',}},}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
    ammo="Knobkierrie",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	sets.precast.WSCounter = {ammo="Falcon Eye",head="Dampening Tam",legs="Hiza. Hizayoroi +2"}
	sets.precast.WSAcc = {ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet=gear.herculean_acc_feet}
	sets.precast.WSFullAcc = {ammo="Falcon Eye",head="Mummu Bonnet +2",neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",body="Mummu Jacket +2",hands="Ryuo Tekko +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet=gear.herculean_acc_feet}
	sets.precast.WSMalignance = {}
	sets.precast.WS.Counter = set_combine(sets.precast.WS, sets.precast.WSCounter)	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.Malignance = set_combine(sets.precast.WS, sets.precast.WSMalignance)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	sets.precast.WS['Howling Fist']    = {
    ammo="Knobkierrie",
    head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+3','STR+10',}},
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {waist="Grunfeld Rope"})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {neck="Caro Necklace",body="Abnoba Kaftan",hands="Ryuo Tekko +1",ring2="Begrudging Ring",waist="Grunfeld Rope",feet=gear.herculean_wsd_feet})
	
	sets.precast.WS["Victory Smite"]   = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ken. Samue +1",
    hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+3','STR+10',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	sets.precast.WS['Shijin Spiral']   = {
    ammo="Knobkierrie",
    head="Ken. Jinpachi +1",
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	
	sets.precast.WS['Dragon Kick']     = {
    ammo="Knobkierrie",
    head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Anch. Gaiters +3",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Tornado Kick']    = {
    ammo="Knobkierrie",
    head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Anch. Gaiters +3",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Spinning Attack'] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+3','STR+10',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	sets.precast.WS['Final Heaven'] =  {
    ammo="Knobkierrie",
    head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
    body={ name="Herculean Vest", augments={'Weapon skill damage +5%','DEX+10',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+7',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'"Cure" potency +6%','Crit.hit rate+2','Weapon skill damage +8%',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Ishvara Earring",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},}
	
	
	sets.precast.WS["Raging Fists"].Counter = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSCounter)
	sets.precast.WS["Howling Fist"].Counter = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSCounter)
	sets.precast.WS["Asuran Fists"].Counter = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSCounter)
	sets.precast.WS["Ascetic's Fury"].Counter = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSCounter, {head="Mummu Bonnet +2",body="Abnoba Kaftan",hands="Ryuo Tekko +1",ring2="Begrudging Ring",waist="Grunfeld Rope",legs="Mummu Kecks +2",feet=gear.herculean_wsd_feet})
	sets.precast.WS["Victory Smite"].Counter = {
    ammo="Knobkierrie",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	sets.precast.WS["Shijin Spiral"].Counter = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSCounter, {})
	sets.precast.WS["Dragon Kick"].Counter = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSCounter)
	sets.precast.WS["Tornado Kick"].Counter = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSCounter)
	
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {head="Mummu Bonnet +2",body="Sayadio's Kaftan",hands="Ryuo Tekko +1",ring2="Begrudging Ring",legs="Mummu Kecks +2",feet="Ken. Sune-Ate +1"})
	sets.precast.WS["Victory Smite"].Acc = {
    ammo="Knobkierrie",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFullAcc, {head="Mummu Bonnet +2",body="Mummu Jacket +2",hands="Ryuo Tekko +1",legs="Mummu Kecks +2",feet="Ken. Sune-Ate +1"})
	sets.precast.WS["Victory Smite"].FullAcc = {
    ammo="Knobkierrie",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)
	sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)
	
	sets.precast.WS["Raging Fists"].Malignance = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMalignance)
	sets.precast.WS["Howling Fist"].Malignance = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMalignance)
	sets.precast.WS["Asuran Fists"].Malignance = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMalignance)
	sets.precast.WS["Ascetic's Fury"].Malignance = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMalignance, {head="Adhemar Bonnet +1",neck="Caro Necklace",body="Abnoba Kaftan",ring1="Begrudging Ring",waist="Grunfeld Rope"})
	sets.precast.WS["Victory Smite"].Malignance = set_combine(sets.precast.WS["Victory Smite"], {head="Malignance Chapeau",body="Malignance Tabard",hands="Malignance Gloves",legs="Malignance Tights",feet="Malignance Boots",})
	sets.precast.WS["Shijin Spiral"].Malignance = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMalignance)
	sets.precast.WS["Dragon Kick"].Malignance = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMalignance)
	sets.precast.WS["Tornado Kick"].Malignance = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMalignance)


	sets.precast.WS['Cataclysm'] = {ammo="Dosis Tathlum",
		neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		hands=gear.herculean_dt_hands,ring1="Shiva Ring +1",
		back="Toro Cape",legs="Nahtirah Trousers"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring2="Defending Ring",ring2="Prolix Ring",
		back="Moonlight Cape",waist="Black Belt",legs=gear.herculean_dt_legs,feet="Hippo. Socks +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Sheltered Ring"}
	

	-- Idle sets
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Hiza. Haramaki +2",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Moonbow Belt +1",
    left_ear="Infused Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back="Moonbeam Cape",}

	sets.idle.Weak = set_combine(sets.idle)

	sets.idle.PDT = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Moonbow Belt +1",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	
	
	-- Defense sets
	sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Moonbow Belt +1",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
		
	-- Defense sets
	sets.defense.HP = set_combine(sets.defense.PDT)

	sets.defense.MDT = set_combine(sets.defense.PDT)
		
	sets.defense.MEVA = set_combine(sets.defense.PDT)

	sets.Kiting = {right_ring="Shneddick Ring",}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
    feet="Anch. Gaiters +3",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}

	sets.engaged.Counter = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body={ name="Hes. Cyclas +3", augments={'Enhances "Formless Strikes" effect',}},
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet={ name="Hes. Gaiters +3", augments={'Enhances "Mantra" effect',}},
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	sets.engaged.Acc = {
    ammo="Staunch Tathlum +1",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	
	sets.engaged.FullAcc = {
    ammo="Staunch Tathlum +1",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	
	sets.engaged.Malignance = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Telos Earring",
    right_ear="Mache Earring +1",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}

	-- Defensive melee hybrid sets
	sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Moonbow Belt +1",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},}
	
	sets.engaged.Counter.PDT = set_combine(sets.defense.PDT)
	sets.engaged.Acc.PDT = set_combine(sets.defense.PDT)
	sets.engaged.FullAcc.PDT = set_combine(sets.defense.PDT)
	sets.engaged.Malignance.PDT = set_combine(sets.defense.PDT)
	sets.engaged.PDTOnly = set_combine(sets.defense.PDT)
	sets.engaged.Counter.PDTOnly = set_combine(sets.defense.PDT)
	sets.engaged.Acc.PDTOnly = set_combine(sets.defense.PDT)
	sets.engaged.FullAcc.PDTOnly = set_combine(sets.defense.PDT)

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.Counter.HF = set_combine(sets.engaged.Counter, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.Malignance.HF = set_combine(sets.engaged.Malignance, {})




	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Impetus = {body="Bhikku Cyclas +1"} --body="Bhikku Cyclas +1"
	sets.buff.Footwork = {}--feet="Shukuyu Sune-Ate"
	
	sets.FootworkWS = {}--feet="Shukuyu Sune-Ate"
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama"}
	
	-- Weapons sets
	sets.weapons.Verethragna = {main="Verethragna"}
	sets.weapons.Spharai = {main="Spharai"}
	sets.weapons.Barehanded = {main=empty}
	sets.weapons.Staff = {main="Malignance Pole"}
	sets.weapons.ProcClub = {main="Mafic Cudgel"}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 20)
	else
		set_macro_page(1, 20)
	end
end
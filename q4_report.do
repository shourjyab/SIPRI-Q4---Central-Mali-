//Q$ themmatic report 



//import excel "C:\Users\Shourjya Deb\ownCloud\WEST AFRICA AND SAHEL PROGRAMME\5. EU Centre Mali (35127)\3. Phases enquêtes\1. Phases études quanti\Phase Q4\7. Data Excel et SPSS\BasededonneesQ4.xlsx", sheet("BasededonneesQ4") firstrow

cd "C:\Users\Shourjya Deb\ownCloud\WEST AFRICA AND SAHEL PROGRAMME\5. EU Centre Mali (35127)\3. Phases enquêtes\1. Phases études quanti\Phase Q4\15. data analysis_shourjya"


//identification 

duplicates report Q1_0_B

tab Q1_0_B

//there are duplicates in the data 

duplicates list 

duplicates tag, gen(dup_tag)

count if dup_tag>0

//so there are no duplicates 


*********************************************************
*********************************************************
*********************************************************
*********creating variable list
*********************************************************
*********************************************************
*********************************************************

/* it is an attempt to standardise the dataset across 
all q1-q6, so there is going to be lot of renaming and variable labels*/

//sort by name 
sort Q1_2

//generate an id - case id 
generate case_id=_n

label variable case_id "unique identification number - analytics generated" 

//facilotator name 
generate facilitator=Q1_1

label variable facilitator "name of the facilitator"

//region 
tab Q1_3

generate region=. 
replace region=1 if Q1_3=="Ségou"
replace region=2 if Q1_3=="Mopti"

label define reg_lab 1 "Ségou" 2 "Mopti"
label values region reg_lab

codebook region 

//cercle 

tab Q1_4

generate cercle=. 

replace cercle=1 if Q1_4=="Bandiagara"
replace cercle=2 if Q1_4=="Bankass"
replace cercle=3 if Q1_4=="Baraoueli"
replace cercle=4 if Q1_4=="Bla"
replace cercle=5 if Q1_4=="Djenné"
replace cercle=6 if Q1_4=="Douentza"
replace cercle=7 if Q1_4=="Koro"
replace cercle=8 if Q1_4=="Macina"
replace cercle=9 if Q1_4=="Mopti"
replace cercle=10 if Q1_4=="Niono"
replace cercle=11 if Q1_4=="San"
replace cercle=12 if Q1_4=="Ségou"
replace cercle=13 if Q1_4=="Tenenkou"
replace cercle=14 if Q1_4=="Tominian"
replace cercle=15 if Q1_4=="Youwarou"

label define cercle_lab 1 "Bandiagara" 2 "Bankass" 3 "Baraoueli" 4 "Bla" 5 "Djenné" 6 "Douentza" ///
7 "Koro" 8 "Macina" 9 "Mopti" 10 "Niono"  ///
11 "San" 12 "Ségou" 13 "Tenenkou" 14 "Tominian" 15 "Youwarou"

label define cercle_lab 5 "Djenné",add

//we can also use a modify options instead of add 


label values cercle cercle_lab 

codebook cercle, tab(100)


//commune data is missing 
//most of village data does not make sense 


//urban-rural; residence 
tab Q1_7
generate residence=. 
replace residence=1 if Q1_7=="Urbain"
replace residence=2 if Q1_7=="Rural"

label define res_lab 1 "Urbain" 2 "Rural"
label values residence res_lab 

codebook residence
label variable residence "urban or rural residence"


//survey contact 
tab Q1_11
generate survey_contact=. 
replace survey_contact=1 if Q1_11=="Oui"
replace survey_contact=2 if Q1_11=="Non"

label define survey_lab 1 "Oui" 2 "Non"
label values survey_contact survey_lab

codebook survey_contact

label variable survey_contact "Someone put you directly in contact with the person being surveyed?" 


//Household / respondent status
tab Q1_12_A

generate res_status=.

replace res_status=2 if Q1_12_A=="Déplacé (malien)"
replace res_status=1 if Q1_12_A=="Résident"
replace res_status=3 if Q1_12_A=="Rétourné"
replace res_status=4 if Q1_12_A=="Rapatrié"
replace res_status=5 if Q1_12_A=="Réfugié (non-malien)"

label define resstatus_lab 1 "Résident" 2 "Déplacé (malien)" 3 "Rétourné" 4 "Rapatrié" 5 "Réfugié (non-malien)"

label values res_status resstatus_lab 

codebook res_status, tab(100)
label variable res_status "Household / respondent status"


//Are you a resident who was born here / came by marriage or work?

tab Q1_12_B

generate res_asso=. 

replace res_asso=1 if Q1_12_B=="Résident : né ici"
replace res_asso=2 if Q1_12_B=="Résident : venu ici par mariage"
replace res_asso=3 if Q1_12_B=="Résident : venu ici pour travailler (raison économique)"
replace res_asso=4 if Q1_12_B=="Résident : autre raison"

label define resasso_lab 1 "Né ici" 2 "Venu ici par mariage" 3 "Venu ici pour travailler" 4 "Autre raison"

label values res_asso resasso_lab 

label variable res_asso "Are you a resident who was born here / came by marriage or work?"

codebook res_asso


//gender 
tab Q1_13

generate gender=. 
replace gender=1 if Q1_13=="Masculin"
replace gender=2 if Q1_13=="Féminin"

label define gender_lab 1 "Masculin" 2 "Féminin"

label values gender gender_lab 

codebook gender

//age 
tab Q1_14 

generate age=Q1_14
sum age

//literacy
tab Q1_15_A

generate literacy=. 
replace literacy=1 if Q1_15_A=="Non-alphabétisé"
replace literacy=2 if Q1_15_A=="Alphabétisé"

label define lit_lab 1 "Non-alphabétisé" 2 "Alphabétisé"
label values literacy lit_lab 

codebook literacy 


//type of school 
tab Q1_15_B

generate school_type=. 
replace school_type=1 if Q1_15_B=="Formelle (publique)"
replace school_type=2 if Q1_15_B=="Formelle (privée)"
replace school_type=3 if Q1_15_B=="Coranique"
replace school_type=4 if Q1_15_B=="Les deux (coranique et formelle)"


label define schtyp_tab 1 "Formelle (publique)" 2 "Formelle (privée)" 3 "Coranique" 4 "Les deux (coranique et formelle)"
label values school_type schtyp_tab 

label variable school_type "type of school"

codebook school_type


//education level - grade level 
tab Q1_15_C

generate educ_lvl=. 
replace educ_lvl=1 if Q1_15_C=="Fondamental premier cycle"
replace educ_lvl=2 if Q1_15_C=="Fondamental second"
replace educ_lvl=3 if Q1_15_C=="Secondaire"
replace educ_lvl=4 if Q1_15_C=="Supérieur (université)"

label define educ_lab 1 "Fondamental premier cycle" 2 "Fondamental second" 3 "Secondaire" 4 "Supérieur (université)"
label values educ_lvl educ_lab 

label variable educ_lvl "education levels"

codebook educ_lvl


//profession 
tab Q1_16

generate prof=. 
replace prof=1 if Q1_16=="Agriculteur"
replace prof=2 if Q1_16=="Eleveur"
replace prof=3 if Q1_16=="Pêcheur"
replace prof=4 if Q1_16=="Commercant"
replace prof=5 if Q1_16=="Employé salarié (non fonctionnaire)"
replace prof=6 if Q1_16=="Fonctionnaire"
replace prof=7 if Q1_16=="Autre"

label define prof_lab 1 "Agriculteur" 2 "Eleveur" 3 "Pêcheur" ///
4 "Commercant" 5 "Employé salarié (non fonctionnaire)" 6 "Fonctionnaire" 7 "Autre"

label values prof prof_lab

label variable prof "profession"

codebook prof, tab (100)

//infant_number 

generate infant_num=Q1_17
sum infant_num

label variable infant_num "number of infants"

save q4_themmatic

//use q4_themmatic

//governance 

**participation and accountability 
foreach var of varlist Q2_1_1_A-Q2_2_5_B {
clonevar gou_`var'=`var'
}


tab gou_Q2_1_1_A
count if gou_Q2_1_1_A=="Oui"
tab gou_Q2_1_1_B

label define gou_lab 1 "Oui" 2 "Non" 3 "Je ne sais pas" 4 "Présent" 5 "Absent"

foreach var of varlist gou_Q2_1_1_A-gou_Q2_2_5_B {

replace `var'="1" if `var'=="Oui"
replace `var'="2" if `var'=="Non"
replace `var'="2" if `var'=="NOn"
replace `var'="3" if `var'=="Je ne sais pas"
replace `var'="." if `var'=="-"
replace `var'="4" if `var'=="Présent"
replace `var'="5" if `var'=="Absent"

destring `var', replace ignore(".")
label values `var' gou_lab

}
save, replace

clear
**institutional effectiveness

use q4_themmatic

foreach var of varlist Q3_1_1_A-Q3_1_6_C {
clonevar gou_`var'=`var'
}

order gou_Q3_1_2_A gou_Q3_1_3_A gou_Q3_1_4_A gou_Q3_1_5_A gou_Q3_1_6_A, after (gou_Q3_1_1_A)
order gou_Q3_1_2_B gou_Q3_1_3_B gou_Q3_1_4_B gou_Q3_1_5_B gou_Q3_1_6_B, after (gou_Q3_1_1_B)
order gou_Q3_1_2_C gou_Q3_1_3_C gou_Q3_1_4_C gou_Q3_1_5_C gou_Q3_1_6_C, after (gou_Q3_1_1_C)

tab gou_Q3_1_1_A
tab gou_Q3_1_1_B 
tab gou_Q3_1_1_C	 

save, replace 	 

label define serv_ava_lab 1 "Présent dans mon village" 2 "Présent dans le village voisin (< 1 jour de voyage)"  ///
3 "A distance de 1 - 2 jours de voyage" 4 "A distance de plus de 2 jours de voyage" 5 "Je ne sais pas où est le plus proche centre de service"

foreach var of varlist gou_Q3_1_1_A gou_Q3_1_2_A gou_Q3_1_3_A gou_Q3_1_4_A gou_Q3_1_5_A gou_Q3_1_6_A{
replace `var'="1" if `var'=="Présent dans mon village"
replace `var'="2" if `var'=="Présent dans le village voisin (<1 jour de voyage)"
replace `var'="3" if `var'=="A distance de 1 - 2 jours de voyage"
replace `var'="4" if `var'=="A distance de plus de 2 jours de voyage"
replace `var'="5" if `var'=="Je ne sais pas où est le plus proche centre de service"

destring `var', replace
label values `var' serv_ava_lab	 

}	 

//checks 
tab gou_Q3_1_1_A
	 
save, replace

tab gou_Q3_1_1_B 

label define serv_use_lab 1 "Oui" 2 "Non"

foreach var of varlist gou_Q3_1_1_B gou_Q3_1_2_B gou_Q3_1_3_B gou_Q3_1_4_B gou_Q3_1_5_B gou_Q3_1_6_B{
replace `var'="1" if `var'=="Oui"
replace `var'="2" if `var'=="Non"
replace `var'="." if `var'=="-"
 

destring `var', replace ignore(".")

label values `var' serv_use_lab	
}

save, replace

tab gou_Q3_1_1_C

label define serv_sat_lab 1 "Pas satisfait" 2 "Peu satisfait" 3 "Neutre" ///
4 "Satisfait" 5 "Très satisfait" 6 "Pas d'avis"

foreach var of varlist gou_Q3_1_1_C gou_Q3_1_2_C gou_Q3_1_3_C gou_Q3_1_4_C gou_Q3_1_5_C gou_Q3_1_6_C{
replace `var'="1" if `var'=="Pas satisfait"
replace `var'="2" if `var'=="Peu satisfait"
replace `var'="3" if `var'=="Neutre"
replace `var'="4" if `var'=="Satisfait"
replace `var'="5" if `var'=="Très satisfait"
replace `var'="6" if `var'=="Pas d'avis"
replace `var'="." if `var'=="-"


destring `var', replace ignore(".")

label values `var' serv_sat_lab	
}

save, replace


tab Q3_2_A 
tab Q3_2_B 
tab Q3_2_B_1


clonevar gou_Q3_2_A=Q3_2_A 


replace gou_Q3_2_A ="1" if gou_Q3_2_A=="Oui"
replace gou_Q3_2_A ="2" if gou_Q3_2_A=="Non"
destring gou_Q3_2_A, replace

label define tax_lab 1 "Oui" 2 "Non" 
label values gou_Q3_2_A tax_lab

codebook gou_Q3_2_A

clonevar gou_Q3_2_B=Q3_2_B 

replace gou_Q3_2_B ="1" if gou_Q3_2_B=="Mairie"
replace gou_Q3_2_B ="2" if gou_Q3_2_B=="Chef de village/quartier"
replace gou_Q3_2_B ="3" if gou_Q3_2_B=="Autorité trad./coutumière"
replace gou_Q3_2_B ="4" if gou_Q3_2_B=="Autre"
replace gou_Q3_2_B ="." if gou_Q3_2_B=="-"

destring gou_Q3_2_B, replace

label define taxingbody_lab 1 "Mairie" 2 "Chef de village/quartier" 3 "Autorité trad./coutumière" 4 "Autre"
label values gou_Q3_2_B taxingbody_lab

codebook gou_Q3_2_B 

save, replace
	 
use q4_themmatic	 
clear

//2.5.A
tab Q2_5_A

generate gou_Q2_5_A=Q2_5_A
//1 oui 2 non 3 je sais pas


replace gou_Q2_5_A="1" if gou_Q2_5_A=="Oui"
replace gou_Q2_5_A="2" if gou_Q2_5_A=="Non"
replace gou_Q2_5_A="3" if gou_Q2_5_A=="Je ne sais pas"

destring gou_Q2_5_A, replace

label define dev_label 1 "Oui" 2 "Non" 3 "Je ne sais pas"

label values gou_Q2_5_A dev_label

codebook gou_Q2_5_A



//2.5.c
tab Q2_5_C

/*Code : 1 = Etat malien ; 2 = ONG malienne ;
 3 = Union européenne ; 4 = Organisation des Nations unies 
 ; 5 = ONG internationale ; 6 = Organisation religieuse ; 
 7 = Autre ; 8 = Je ne sais pas*/

generate gou_Q2_5_C=Q2_5_C

replace gou_Q2_5_C="1" if gou_Q2_5_C=="Etat malien"
replace gou_Q2_5_C="2" if gou_Q2_5_C=="ONG malienne"
replace gou_Q2_5_C="3" if gou_Q2_5_C=="Union europèenne"
replace gou_Q2_5_C="4" if gou_Q2_5_C=="Organisation des Nations Unies"
replace gou_Q2_5_C="5" if gou_Q2_5_C=="ONG internationale"
replace gou_Q2_5_C="6" if gou_Q2_5_C=="Organisation religieuse"
replace gou_Q2_5_C="7" if gou_Q2_5_C=="Autre"
replace gou_Q2_5_C="8" if gou_Q2_5_C=="Je ne sais pas"
replace gou_Q2_5_C="." if gou_Q2_5_C=="-"

destring gou_Q2_5_C, replace

label define lab_devorg 1 "Etat malien" 2 "ONG malienne" 3 "Union europèenne" ///
4 "Organisation des Nations Unies" 5 "ONG internationale" 6 "Organisation religieuse" ///
7 "Autre" 8 "Je ne sais pas"

label values gou_Q2_5_C lab_devorg

codebook gou_Q2_5_C, tab(100)

save, replace


//5.1 - there is a 5.1.a and a 5.1.b 
**need to confirm which one is for what 
tab Q5_1_A
tab Q5_1_B
tab Q5_1_1


generate dev_Q5_1_A=Q5_1_A
generate dev_Q5_1_B=Q5_1_B

tab dev_Q5_1_A

/*
1= Production/vente de produits agricoles ; 
2 = Production/vente de produits d’élevage ;
3 = Production/vente de produits de la pêche ; 
4 = Secteur informel
5 = Commerce / revente des produits ; 
6 = Emploi salarié (non fonctionnaire) ; 
7 = Fonctionnaire / agent de l'Etat / collectivités ; 
8 = Aides/Dons humanitaires (fait par l’Etat ou des organisations) ; 
9 = ; 
10 = Pension de retraite ; 
11 = Chauffeur routier (bus, taxi, camion) ; 
12 = Aides/Dons de la diaspora ; 
13 = Sans source de revenu ;
14 = Autre (à préciser) ___________________
*/

replace dev_Q5_1_A="1" if dev_Q5_1_A=="Production/vente de produits agricoles"
replace dev_Q5_1_A="2" if dev_Q5_1_A=="Production/vente  de produits d?élevage"
replace dev_Q5_1_A="3" if dev_Q5_1_A=="Production/vente de produits de la pêche"
replace dev_Q5_1_A="4" if dev_Q5_1_A=="Secteur informel"
replace dev_Q5_1_A="5" if dev_Q5_1_A=="Commerce / revente des produits de la pêche"
replace dev_Q5_1_A="6" if dev_Q5_1_A=="Emploi salarié (non fonctionnaire)"
replace dev_Q5_1_A="7" if dev_Q5_1_A=="Fonctionnaire / agent de l'Etat / collectivités"
replace dev_Q5_1_A="8" if dev_Q5_1_A=="Aides/Dons humanitaires (fait par l?Etat ou des organisations)"
**replace dev_Q5_1_A="9" if dev_Q5_1_A==""
replace dev_Q5_1_A="10" if dev_Q5_1_A=="Pension de retraite"
replace dev_Q5_1_A="11" if dev_Q5_1_A=="Chauffeur routier  (bus, taxi, camion)"
replace dev_Q5_1_A="12" if dev_Q5_1_A=="Aides/Dons de la diaspora"
replace dev_Q5_1_A="13" if dev_Q5_1_A=="Sans source de revenu"
replace dev_Q5_1_A="14" if dev_Q5_1_A=="Autre"


tab dev_Q5_1_A

tab dev_Q5_1_B


replace dev_Q5_1_B="1" if dev_Q5_1_B=="Production/vente de produits agricoles"
replace dev_Q5_1_B="2" if dev_Q5_1_B=="Production/vente  de produits d?élevage"
replace dev_Q5_1_B="3" if dev_Q5_1_B=="Production/vente de produits de la pêche"
replace dev_Q5_1_B="4" if dev_Q5_1_B=="Secteur informel"
replace dev_Q5_1_B="5" if dev_Q5_1_B=="Commerce / revente des produits de la pêche"
replace dev_Q5_1_B="6" if dev_Q5_1_B=="Emploi salarié (non fonctionnaire)"
replace dev_Q5_1_B="7" if dev_Q5_1_B=="Fonctionnaire / agent de l'Etat / collectivités"
replace dev_Q5_1_B="8" if dev_Q5_1_B=="Aides/Dons humanitaires (fait par l?Etat ou des organisations)"
**replace dev_Q5_1_A="9" if dev_Q5_1_A==""
replace dev_Q5_1_B="10" if dev_Q5_1_B=="Pension de retraite"
replace dev_Q5_1_B="11" if dev_Q5_1_B=="Chauffeur routier  (bus, taxi, camion)"
replace dev_Q5_1_B="12" if dev_Q5_1_B=="Aides/Dons de la diaspora"
replace dev_Q5_1_B="13" if dev_Q5_1_B=="Sans source de revenu"
replace dev_Q5_1_B="14" if dev_Q5_1_B=="Autre"


label define lab_householdprof 1 "Production/vente de produits agricoles" 2 "Production/vente  de produits d’élevage" ///
3 "Production/vente de produits de la pêche" 4 "Secteur informel" 5 "Commerce / revente des produits de la pêche" ///
6 "Emploi salarié (non fonctionnaire)" 7 "Fonctionnaire / agent de l'Etat / collectivités" ///
8 "Aides/Dons humanitaires (fait par l?Etat ou des organisations)" 10 "Pension de retraite" 11 "Chauffeur routier  (bus, taxi, camion)" ///
12 "Aides/Dons de la diaspora" 13 "Sans source de revenu" 14 "Autre"

foreach var of varlist dev_Q5_1_A dev_Q5_1_B{
destring `var', replace
label values `var'  lab_householdprof 
}


codebook dev_Q5_1_A dev_Q5_1_B, tab (100) 

save, replace

//6.1
tab Q6_1

generate dev_Q6_1=Q6_1

replace dev_Q6_1="1" if dev_Q6_1=="Oui"
replace dev_Q6_1="2" if dev_Q6_1=="Non"

destring dev_Q6_1, replace

label define lab_farm 1 "Oui" 2 "Non"
label values dev_Q6_1 lab_farm

tab dev_Q6_1
save, replace

codebook dev_Q6_1

save, replace

//6.3.A

tab Q6_3_A

generate dev_Q6_3_A=Q6_3_A
tab dev_Q6_3_A

replace dev_Q6_3_A="1" if dev_Q6_3_A=="Oui"
replace dev_Q6_3_A="2" if dev_Q6_3_A=="Non"
replace dev_Q6_3_A="." if dev_Q6_3_A=="-"

destring dev_Q6_3_A, replace

label define lab_housefarming 1 "Oui" 2 "Non"
label values dev_Q6_3_A lab_housefarming

codebook dev_Q6_3_A

save, replace

//6.3.B
tab Q6_3_B

generate dev_Q6_3_B=Q6_3_B

replace dev_Q6_3_B="." if dev_Q6_3_B=="-"

replace dev_Q6_3_B="1" if dev_Q6_3_B=="Loués"
replace dev_Q6_3_B="2" if dev_Q6_3_B=="Prêtés"
replace dev_Q6_3_B="4" if dev_Q6_3_B=="Autre"

label define lab_agri 1 "Loués" 2 "Prêtés" 4 "Autre"

destring dev_Q6_3_B, replace 

label values dev_Q6_3_B lab_agri

codebook dev_Q6_3_B

save, replace

//tab 6.2
tab Q6_2_B
tab Q6_2_B_1


drop devQ6_2_B

generate devQ6_2_B=Q6_2_B

replace devQ6_2_B="1" if devQ6_2_B=="Pas d'accès à la terre : problème foncier"
replace devQ6_2_B="2" if devQ6_2_B=="Pas d?accès à la terre : insecurité"
replace devQ6_2_B="3" if devQ6_2_B=="Manque d?intrants agricoles"
replace devQ6_2_B="4" if devQ6_2_B=="Manque de main d??uvre, maladie"
replace devQ6_2_B="5" if devQ6_2_B=="Sols trop pauvres"
replace devQ6_2_B="6" if devQ6_2_B=="Manque de pluie"
replace devQ6_2_B="7" if devQ6_2_B=="Autre (à préciser)"
replace devQ6_2_B="13" if devQ6_2_B=="7"
replace devQ6_2_B="7" if devQ6_2_B=="Manque de moyens financiers"
replace devQ6_2_B="8" if devQ6_2_B=="Urbanisation/ habitation"
replace devQ6_2_B="9" if devQ6_2_B=="Insecurité générale"
replace devQ6_2_B="10" if devQ6_2_B=="Mesures introduites par les autorités en lien avec l?insécurité (interdiction de circulation)"
replace devQ6_2_B="11" if devQ6_2_B=="Jamais cultivé, autre profession/travail"
replace devQ6_2_B="12" if devQ6_2_B=="Pas seconde raison"
replace devQ6_2_B="14" if devQ6_2_B=="Pas de moyen de transport"
replace devQ6_2_B="." if devQ6_2_B=="-"


label define lab_farmreasons 1 "Pas d’accès à la terre : problème foncier" 2 "Pas d’accès à la terre : insecurité"  ///
3 "Manque d’intrants agricoles" 4 "Manque de main d’oeuvre, maladie" 5 "Sols trop pauvres" 6 "Manque de pluie" ///
7 "Manque de moyens financiers" 8 "Urbanisation/ habitation" 9 "Insecurité générale" 10 "Mesures introduites par les autorités" ///
11 "Jamais cultivé, autre profession/travail" 12 "Pas seconde raison" 13 "Autre (à préciser)" 14 "Pas de moyen de transport"

destring devQ6_2_B, replace 

label values devQ6_2_B lab_farmreasons

save, replace 


//6.4


/*Quelle est la source principale d’approvisionnement en 
eau pour la production agricole ?
Code :
1 = Eau de pluie ; 2 = Puits privés ;
3 = Puits publics ; 4 = Rivière, fleuve, ruisseau, canal 
; 5 = Tank, réservoir ; 6 =*/

tab Q6_4
generate dev_Q6_4=Q6_4

replace dev_Q6_4="1" if dev_Q6_4=="Eau de pluie"
replace dev_Q6_4="2" if dev_Q6_4=="Puits privés"
replace dev_Q6_4="3" if dev_Q6_4=="Puits publics"
replace dev_Q6_4="4" if dev_Q6_4=="Rivière, fleuve, ruisseau, canal"
replace dev_Q6_4="5" if dev_Q6_4=="Tank, réservoir"
replace dev_Q6_4="." if dev_Q6_4=="-"

destring dev_Q6_4, replace

label define lab_watersupply 1 "Eau de pluie" 2 "Puits privés" 3 "Puits publics" 4 "Rivière, fleuve, ruisseau, canal" 5 "Tank, réservoir"

label values dev_Q6_4 lab_watersupply

codebook dev_Q6_4

save, replace 


//Q6_5_A 

tab Q6_5_A

generate dev_Q6_5_A=Q6_5_A

tab dev_Q6_5_A

replace dev_Q6_5_A="1" if dev_Q6_5_A=="Oui"
replace dev_Q6_5_A="2" if dev_Q6_5_A=="Non"
replace dev_Q6_5_A="." if dev_Q6_5_A=="-"

destring dev_Q6_5_A, replace 

label define lab_probfield 1 "Oui" 2 "Non"

label values dev_Q6_5_A lab_probfield

save, replace 




//Q6_5_B 
//Q6_5_B_1

generate dev_Q6_5_B=Q6_5_B
generate dev_Q6_5_B_1=Q6_5_B_1

tab dev_Q6_5_B
tab dev_Q6_5_B_1

/*1 = Climat (sècheresse, inondation, criquets)
2 = Insécurité, conflit (dans la zone où se trouvent les champs)
3 = Problème foncier
4 = Autre (à préciser)*/ 

replace dev_Q6_5_B="1" if dev_Q6_5_B=="Climat (sécheresse, inondation, criquets)"
replace dev_Q6_5_B="2" if dev_Q6_5_B=="Insécurité, conflit (dans la zone où se trouvent les champs)"
replace dev_Q6_5_B="3" if dev_Q6_5_B=="Problème foncier"
replace dev_Q6_5_B="4" if dev_Q6_5_B=="Autre (préciser)"
replace dev_Q6_5_B="." if dev_Q6_5_B=="-"

destring dev_Q6_5_B, replace

label define lab_probfieldmain 1 "Climat (sécheresse, inondation, criquets)" ///
2 "Insécurité, conflit (dans la zone où se trouvent les champs)" 3 "Problème foncier" 4 "Autre (préciser)"

label values dev_Q6_5_B lab_probfieldmain

codebook dev_Q6_5_B

save, replace 

//6.6

tab Q6_6

generate dev_Q6_6=Q6_6


/*1 = Nourriture pour la famille (subsistance) ;
2 = Vente sur le marché ;
4 = Vie quotidienne (scolarité et santé)
5 = Dépenses de santé*/

replace dev_Q6_6="1" if dev_Q6_6=="Nourriture pour la famille (subsistance)"
replace dev_Q6_6="2" if dev_Q6_6=="Vente sur le marché"
replace dev_Q6_6="4" if dev_Q6_6=="Vie quotidienne (scolarité  et santé)"
replace dev_Q6_6="5" if dev_Q6_6=="Dépenses de santé"
replace dev_Q6_6="." if dev_Q6_6=="-"

destring dev_Q6_6, replace

label define lab_agriuti 1 "Nourriture pour la famille (subsistance)" /// 
2 "Vente sur le marché" 4 "Vie quotidienne (scolarité  et santé)" 5 "Dépenses de santé"

label values dev_Q6_6 lab_agriuti

save, replace 

//7.1

tab Q7_1

generate dev_Q7_1=Q7_1

replace dev_Q7_1="1" if dev_Q7_1=="Oui"
replace dev_Q7_1="2" if dev_Q7_1=="Non"

destring dev_Q7_1, replace

label define lab_ownliv 1 "Oui" 2 "Non"
label values dev_Q7_1 lab_ownliv


//7.2

foreach var of varlist Q7_2_1 Q7_2_2 Q7_2_3 Q7_2_4 Q7_2_5 {
clonevar dev_`var'=`var'
}


foreach var of varlist dev_Q7_2_1-dev_Q7_2_5 {
replace `var'="." if `var'=="-"
destring `var', replace
tab `var'
}

//7.3 
tab Q7_3 

generate dev_Q7_3=Q7_3 

/*1 = Pas d’accès aux pâturages ;
2 = Pas d’accès à l’eau ;
3 = Vol d’animaux
4 = Insécurité, conflit ;*/

replace dev_Q7_3="1" if dev_Q7_3=="Pas d?accès aux pâturages"
replace dev_Q7_3="2" if dev_Q7_3=="Pas d?accès à l?eau"
replace dev_Q7_3="3" if dev_Q7_3=="Vol d?animaux"
replace dev_Q7_3="4" if dev_Q7_3=="Insécurité, conflit"
replace dev_Q7_3="." if dev_Q7_3=="-"

destring dev_Q7_3, replace 

label define lab_husb 1 "Pas d’accès aux pâturages" 2 "Pas d’accès à l’eau" ///
3 "Vol d’animaux" 4 "Insécurité, conflit"

label values dev_Q7_3 lab_husb

codebook dev_Q7_3

save, replace

//Q7_4
tab Q7_4 



/*
1 = "Nourriture pour la famille (subsistance)" ;
2 = "Vente sur le marché" ;
3 = "Vie quotidienne (scolarité et santé)"
5 = "Dépenses de santé" ;*/

generate dev_Q7_4=Q7_4

replace dev_Q7_4="1" if dev_Q7_4=="Nourriture pour la famille (subsistance)"
replace dev_Q7_4="2" if dev_Q7_4=="Vente sur le marché"
replace dev_Q7_4="3" if dev_Q7_4=="Vie quotidienne (scolarité  et santé)"
replace dev_Q7_4="5" if dev_Q7_4=="Dépenses de santé"
replace dev_Q7_4="." if dev_Q7_4=="-"

destring dev_Q7_4, replace

label define lab_eleuti 1 "Nourriture pour la famille (subsistance)" ///
2 "Vente sur le marché" 3 "Vie quotidienne (scolarité  et santé)" 5 "Dépenses de santé", modify

label values dev_Q7_4 lab_eleuti

codebook dev_Q7_4

save, replace


//8.4 is 8.5 - question mislabelling 

//Q8_4_A Q8_4_B

generate dev_Q8_4_A=Q8_4_A
generate dev_Q8_4_B=Q8_4_B

replace dev_Q8_4_A="1" if dev_Q8_4_A=="Oui"
replace dev_Q8_4_A="2" if dev_Q8_4_A=="Non"
replace dev_Q8_4_A="." if dev_Q8_4_A=="-"

destring dev_Q8_4_A, replace 

label define lab_pecheprob 1 "Oui" 2 "Non"

label values dev_Q8_4_A lab_pecheprob

codebook dev_Q8_4_A

/*Code :
1 = Niveau d’eau ;
3 = Manque de débouchés pour commercialiser
5 = Insécurité ;
7 = Autre*/

tab dev_Q8_4_B

replace dev_Q8_4_B="1" if dev_Q8_4_B=="Niveau d?eau"
replace dev_Q8_4_B="3" if dev_Q8_4_B=="Manque de débouchés pour commercialiser"
replace dev_Q8_4_B="5" if dev_Q8_4_B=="Insécurité"
replace dev_Q8_4_B="7" if dev_Q8_4_B=="Autre"
replace dev_Q8_4_B="." if dev_Q8_4_B=="-"

destring dev_Q8_4_B, replace

label define lab_pecheuti 1 "Niveau d’eau" 3 "Manque de débouchés pour commercialiser" ///
5 "Insécurité" 7 "Autre"

label values dev_Q8_4_B lab_pecheuti

codebook dev_Q8_4_B

save, replace

//Q9_1 Q9_4

tab Q9_1
generate dev_Q9_1=Q9_1

replace dev_Q9_1="1" if dev_Q9_1=="Oui"
replace dev_Q9_1="2" if dev_Q9_1=="Non"

destring dev_Q9_1, replace

label define lab_bus 1 "Oui" 2 "Non"
label values dev_Q9_1 lab_bus

codebook dev_Q9_1 

save, replace 

tab Q9_4
generate dev_Q9_4=Q9_4

/*
1 = Manque de clients ;
2 = Augmentation des prix;
3 = Limitation des déplacements (barrages) ;
4 = Insécurité (Vol, braquage) ;
5 = Autre (à préciser)_________________
*/

replace dev_Q9_4="1" if dev_Q9_4=="Manque de clients"
replace dev_Q9_4="2" if dev_Q9_4=="Augmentation des prix"
replace dev_Q9_4="3" if dev_Q9_4=="Limitation des déplacements (barrages)"
replace dev_Q9_4="4" if dev_Q9_4=="Insécurité (Vol, braquage)"
replace dev_Q9_4="5" if dev_Q9_4=="Autre (à préciser)"


label define lab_busprob 1 "Manque de clients" 2 "Augmentation des prix" ///
3 "Limitation des déplacements (barrages)" 4 "Insécurité (Vol, braquage)" ///
5 "Autre (à préciser)"

destring dev_Q9_4, replace

label values dev_Q9_4 lab_busprob

codebook dev_Q9_4

save, replace 

//10.1.B

tab Q10_1_B_1

label define lab_act 1 "Oui" 2 "Non"


foreach var of varlist Q10_1_B_1-Q10_1_B_14 {
clonevar dev_`var'=`var'

}


foreach var of varlist dev_Q10_1_B_1-dev_Q10_1_B_14 {

replace `var'="." if `var'=="-"
replace `var'="2" if `var'=="Non"
replace `var'="1" if `var'=="Oui"

destring `var', replace 

label values `var' lab_act

}

//10.2


foreach var of varlist Q10_2_1-Q10_2_9 {
clonevar dev_`var'=`var'
}


label define lab_solc 0 "Non" 1 "Oui" 2 "Je ne sais pas" 3 "Pas possible de poser la qestion"

tab dev_Q10_2_1
foreach var of varlist dev_Q10_2_1-dev_Q10_2_9 {

replace `var'="." if `var'=="-"
replace `var'="0" if `var'=="Non"
replace `var'="1" if `var'=="Oui"
replace `var'="2" if `var'=="Je ne sais pas"
replace `var'="3" if `var'=="Pas possible de poser la qestion"

destring `var', replace 

label values `var' lab_solc

}

//11.9 and 11.10
tab Q11_9 
tab Q11_10

generate dev_Q11_9=Q11_9 
generate dev_Q11_10=Q11_10 


replace dev_Q11_9="." if dev_Q11_9=="-"
replace dev_Q11_9="1" if dev_Q11_9=="Oui"
replace dev_Q11_9="2" if dev_Q11_9=="Non"

destring dev_Q11_9, replace

label define lab_vac 1 "Oui" 2 "Non"

label values dev_Q11_9 lab_vac

codebook dev_Q11_9

//tab 11.10
/*1 = Poste de santé/dispensaire ; 2 = Centre de santé communal ;
3 = Centre de santé de référence ; 4 = Hôpital ;
5 = Tradithérapeute ; 6 = Automédication (pharmacie) ;
7 = Automedication (de la rue) ; 8 = Sans traitement*/

tab dev_Q11_10


replace dev_Q11_10="1" if dev_Q11_10=="Poste de santé/dispensaire"
replace dev_Q11_10="2" if dev_Q11_10=="Centre de santé communal"
replace dev_Q11_10="3" if dev_Q11_10=="Centre de santé de référence"
replace dev_Q11_10="4" if dev_Q11_10=="Hôpital"
replace dev_Q11_10="5" if dev_Q11_10=="Tradithérapeute"
replace dev_Q11_10="6" if dev_Q11_10=="Automédication (pharmacie)"
replace dev_Q11_10="7" if dev_Q11_10=="Automedication (de la rue)"
replace dev_Q11_10="8" if dev_Q11_10=="Sans traitement"
replace dev_Q11_10="." if dev_Q11_10=="-"

destring dev_Q11_10, replace 


label define lab_famill 1 "Poste de santé/dispensaire" 2 "Centre de santé communal" ///
3 "Centre de santé de référence" 4 "Hôpital" 5 "Tradithérapeute" 6 "Automédication (pharmacie)" ///
7 "Automedication (de la rue)" 8 "Sans traitement"

label values dev_Q11_10 lab_famill

codebook dev_Q11_10

save, replace 

//12.3

foreach var of varlist Q12_3_1-Q12_3_10 { 
clonevar sec_`var'=`var'
}

label define lab_secact 1 "Oui" 2 "Non"

foreach var of varlist sec_Q12_3_1-sec_Q12_3_10 {

replace `var'="." if `var'=="-"
replace `var'="1" if `var'=="Oui"
replace `var'="2" if `var'=="Non"

destring `var', replace 
label values `var' lab_secact

}

//12.7

foreach var of varlist Q12_7_1-Q12_7_20 {
clonevar sec_`var'=`var'
}


foreach var of varlist sec_Q12_7_1-sec_Q12_7_20 {

replace `var'="." if `var'=="-"
replace `var'="1" if `var'=="Oui"
replace `var'="2" if `var'=="Non"

destring `var', replace 
label values `var' lab_secact

}

//age groups
tab age

generate age_groups=.
replace age_groups=1 if age<=35
replace age_groups=2 if age>35

label define age_lab 1 "Jeunes" 2 "Adulte"
label values age_groups age_lab

codebook age_groups

save, replace



//Q8_1

tab Q8_1

generate dev_Q8_1=Q8_1

replace dev_Q8_1="1" if dev_Q8_1=="Oui"
replace dev_Q8_1="2" if dev_Q8_1=="Non"

label define lab_fishhh 1 "Oui" 2 "Non"

destring dev_Q8_1, replace

label values dev_Q8_1 lab_fishhh

codebook dev_Q8_1

save, replace 


//Q8_4 
**question iscoded wrong - 8.3 in the actual dataset 

tab Q8_3

generate dev_Q8_3=Q8_3

/*
Code :
1 = Nourriture pour la famille (subsistance) ;
2 = Vente sur le marché ;
3 = Vie quotidienne (scolarité et santé)
*/

replace dev_Q8_3="." if dev_Q8_3=="-"
replace dev_Q8_3="1" if dev_Q8_3=="Nourriture pour la famille (subsistance)"
replace dev_Q8_3="2" if dev_Q8_3=="Vente sur le marché"
replace dev_Q8_3="3" if dev_Q8_3=="Vie quotidienne (scolarité  et santé)"


destring dev_Q8_3, replace

label define lab_fishuti 1 "Nourriture pour la famille (subsistance)" 2 "Vente sur le marché"
3 "Vie quotidienne (scolarité  et santé)", modify

label define lab_fishuti 3 "Vie quotidienne (scolarité  et santé)", modify

label values dev_Q8_3 lab_fishuti

codebook dev_Q8_3

save, replace


//Q11_8_A Q11_8_B Q11_8_C Q11_8_D

foreach var of varlist Q11_8_A Q11_8_B Q11_8_C Q11_8_D {
clonevar dev_`var'=`var'
}

tab dev_Q11_8_A

replace dev_Q11_8_A="0" if dev_Q11_8_A=="Non"
replace dev_Q11_8_A="1" if dev_Q11_8_A=="Oui"
replace dev_Q11_8_A="2" if dev_Q11_8_A=="Pas d'enfant dans le ménage"

//Code : 1 = Oui ; 0 = Non ; 2 = Pas d’enfant dans le ménage

destring dev_Q11_8_A, replace

label define lab_child 0 "Non" 1 "Oui" 2 "Pas d'enfant dans le ménage"

label values dev_Q11_8_A lab_child

codebook dev_Q11_8_A

save, replace 

//Q11_8_B
tab dev_Q11_8_B

replace dev_Q11_8_B="." if dev_Q11_8_B=="-"
replace dev_Q11_8_B="1" if dev_Q11_8_B=="Pas d?école"
replace dev_Q11_8_B="2" if dev_Q11_8_B=="École fermée"
replace dev_Q11_8_B="3" if dev_Q11_8_B=="Manque d?enseignant"
replace dev_Q11_8_B="4" if dev_Q11_8_B=="Aide à la famille (travaux des champs, travaux domestiques)"
replace dev_Q11_8_B="5" if dev_Q11_8_B=="École coranique"


/*Code : 1 = Pas d’école ; 2 = École fermée ; 
3 = Manque d’enseignant ; 
4= Aide à la famille (travaux des champs, travaux domestiques) ;
 5= École coranique
 */
 
destring dev_Q11_8_B, replace
 
label define lab_childschool 1 "Pas d’école" 2 "École fermée" 3 "Manque d’enseignant" ///
4 "Aide à la famille (travaux des champs, travaux domestiques)" 5 "École coranique"
 
label values dev_Q11_8_B lab_childschool
 
codebook dev_Q11_8_B
 
save, replace

//Q11_8_C

tab Q11_8_C

tab dev_Q11_8_C

replace dev_Q11_8_C="." if dev_Q11_8_C=="-"
replace dev_Q11_8_C="1" if dev_Q11_8_C=="Oui"
replace dev_Q11_8_C="0" if dev_Q11_8_C=="Non"

destring dev_Q11_8_C, replace

label define lab_childeducrec 1 "Oui" 0 "Non"

label values dev_Q11_8_C lab_childeducrec

codebook dev_Q11_8_C

save, replace 

 
//Q11_8_D

/*1 = Ecole fermée, abandonnée. 2 = Insécurité
3 = Déplacement 4 = Grève des enseignants
5 =
6 = Manque de moyens de la famille (frais, fourniture, nourriture)
7 = L’école est trop loin (distance) 8 =
9 =
10 = Autre (à préciser)_________________*/

tab dev_Q11_8_D


replace dev_Q11_8_D="." if dev_Q11_8_D=="-"
replace dev_Q11_8_D="1" if dev_Q11_8_D=="Ecole fermée, abandonnée"
replace dev_Q11_8_D="2" if dev_Q11_8_D=="Insécurité"
replace dev_Q11_8_D="3" if dev_Q11_8_D=="Déplacement"
replace dev_Q11_8_D="4" if dev_Q11_8_D=="Grève des enseignants"
replace dev_Q11_8_D="6" if dev_Q11_8_D=="Manque de moyens de la famille (frais, fourniture, nourriture)"
replace dev_Q11_8_D="7" if dev_Q11_8_D=="L?école est trop loin (distance)"
replace dev_Q11_8_D="10" if dev_Q11_8_D=="Autre (à préciser)"

destring dev_Q11_8_D, replace

label define label_schoolreason 1 "Ecole fermée, abandonnée" 2 "Insécurité" 3 "Déplacement" ///
4 "Grève des enseignants" 6 "Manque de moyens de la famille (frais, fourniture, nourriture)"  ///
7 "L’école est trop loin (distance)" 10 "Autre (à préciser)"
 
label values dev_Q11_8_D label_schoolreason

codebook dev_Q11_8_D

save, replace 




*********************************************************
*********************************************************
*********************************************************
*********analysis
*********************************************************
*********************************************************
*********************************************************



//identity variables 

tab region

tab cercle 

tab residence 

tab survey_contact 

tab res_status 

tab res_asso 

tab gender 

sum age 

tab literacy 

tab school_type 

tab educ_lvl 

tab prof 

sum infant_num

//2.2 A
tab gou_Q2_2_1_A 
tab gou_Q2_2_2_A 
tab gou_Q2_2_3_A 
tab gou_Q2_2_4_A 
tab gou_Q2_2_5_A

save, replace 

//2.3 check 

label define lab_confi 1 "Pas de confiance" 2 "Peu de confiance" 3 "Confiance (souvent)" 4 "Beaucoup de confiance (toujours)" 5 "Je ne connais pas l'acteur" 6 "Pas possible de poser la question" 7 "Ne sais pas"

foreach var of varlist Q2_3_1 Q2_3_2 Q2_3_3 Q2_3_4 Q2_3_5 Q2_3_6 Q2_3_7  ///
Q2_3_8 Q2_3_9 Q2_3_10 Q2_3_11 Q2_3_12 Q2_3_13 Q2_3_14 Q2_3_15 {

replace `var'="1" if `var'=="Pas de confiance"
replace `var'="2" if `var'=="Peu de confiance"
replace `var'="3" if `var'=="Confiance (souvent)"
replace `var'="4" if `var'=="Beaucoup de confiance (toujours)"
replace `var'="5" if `var'=="Je ne connais pas l'acteur"
replace `var'="6" if `var'=="Pas possible de poser la question"
replace `var'="7" if `var'=="Ne sais pas"

destring `var', replace

label values `var' lab_confi
asdoc tab `var'
}

foreach var of varlist Q2_3_1 Q2_3_2 Q2_3_3 Q2_3_4 Q2_3_5 Q2_3_6 Q2_3_7  ///
Q2_3_8 Q2_3_9 Q2_3_10 Q2_3_11 Q2_3_12 Q2_3_13 Q2_3_14 Q2_3_15 {

clonevar gou_`var'=`var'
tab gou_`var'
}

foreach var of varlist gou_Q2_3_1 gou_Q2_3_2 gou_Q2_3_3 gou_Q2_3_4 gou_Q2_3_5 gou_Q2_3_6 gou_Q2_3_7 ///
gou_Q2_3_8 gou_Q2_3_9 gou_Q2_3_10 gou_Q2_3_11 gou_Q2_3_12 gou_Q2_3_13 gou_Q2_3_14 gou_Q2_3_15 {

asdoc tab `var'
}





//coding error in the questionnaire regarding the number questions in 2.3 
**they should be 15 but they are 16 because of mistake in numbering. 

//3.1 - gou_Q3_1_1_A gou_Q3_1_2_A gou_Q3_1_3_A gou_Q3_1_4_A gou_Q3_1_5_A gou_Q3_1_6_A

foreach var of varlist gou_Q3_1_1_A gou_Q3_1_2_A gou_Q3_1_3_A gou_Q3_1_4_A gou_Q3_1_5_A gou_Q3_1_6_A {
tab `var'
}


foreach var of varlist gou_Q3_1_1_A gou_Q3_1_2_A gou_Q3_1_3_A gou_Q3_1_4_A gou_Q3_1_5_A gou_Q3_1_6_A {
asdoc tab `var'
}





save, replace 

//age 
asdoc tab age 


//gou_Q2_5_A

tab gou_Q2_5_A

//gou_Q2_5_C
tab gou_Q2_5_C

//5.1.1
tab dev_Q5_1_A
tab dev_Q5_1_B

asdoc tab dev_Q5_1_A
asdoc tab dev_Q5_1_B

//6.1

tab dev_Q6_1

tab region dev_Q6_1

tab cercle dev_Q6_1

tab region dev_Q6_1, row

tab cercle dev_Q6_1, row

asdoc tab dev_Q6_1

asdoc tab region dev_Q6_1, row

asdoc tab cercle dev_Q6_1, row

//6.3.A

tab dev_Q6_3_A 

tab region dev_Q6_3_A, row nofreq

asdoc tab dev_Q6_3_A 
asdoc tab region dev_Q6_3_A, row nofreq

//6.3.B

tab dev_Q6_3_B

//6.2

tab devQ6_2_B

//6.4

tab dev_Q6_4 
asdoc tab dev_Q6_4 

//6.5.a 

tab dev_Q6_5_A 
tab region dev_Q6_5_A, row nofreq

//6.5.B

tab dev_Q6_5_B

tab cercle dev_Q6_5_B

tab cercle dev_Q6_5_B, row nofreq

asdoc tab dev_Q6_5_B
asdoc tab cercle dev_Q6_5_B, row nofreq

tab dev_Q6_5_B_1

tab cercle dev_Q6_5_B_1

count if dev_Q6_5_B_1=" "

tab 

codebook cercle, tab(100)

codebook dev_Q6_5_B 

preserve
keep if cercle==12 | cercle==3
keep cercle dev_Q6_5_B dev_Q6_5_B_1
keep if dev_Q6_5_B==4
sort cercle
edit
restore


//6.6
tab dev_Q6_6 

//7.1
tab dev_Q7_1

//7.2 

foreach var of varlist dev_Q7_2_1-dev_Q7_2_5 {
//tab `var'
sum `var'
}

//7.3
tab dev_Q7_3

//7.4
tab dev_Q7_4 

//8.4 
tab dev_Q8_4_A
tab dev_Q8_4_B

//3.1C
tab gou_Q3_1_1_C

//9.1
tab dev_Q9_1 

//9.4
tab dev_Q9_4

//dev_Q10_1_B_1 dev_Q10_1_B_14
foreach var of varlist dev_Q10_1_B_1-dev_Q10_1_B_14 {
asdoc tab `var'

}


tab dev_Q10_1_B_1, nofreq

//dev_Q10.2 
//dev_Q10_2_1 dev_Q10_2_9

foreach var of varlist dev_Q10_2_1-dev_Q10_2_9 {
asdoc tab `var'

}

//11.9
tab dev_Q11_9 
//11.10
tab  dev_Q11_10

//12.3
foreach var of varlist sec_Q12_3_1-sec_Q12_3_10 {
asdoc tab `var'

}
//recheck on 12.3 

foreach var of varlist Q12_3_1-Q12_3_10 {
tab `var'

}




//12.7

foreach var of varlist sec_Q12_7_1-sec_Q12_7_20 {
asdoc tab `var'

}

//intro
tab case_id
tab gender
tab	region
tab gender if region==1
tab gender if region==2
tab gender
codebook region

tab age_groups
codebook age_groups

tab gender if age_group==1 
tab gender if age_group==2 


//8.1 

tab dev_Q8_1

//8.3
tab dev_Q8_3



//9.4-cercles 

tab cercle dev_Q9_4, row nofreq

//11.8.A
tab dev_Q11_8_A 

//11.8.B
tab dev_Q11_8_B

//11.8.C
tab dev_Q11_8_C


//11.8.D
tab dev_Q11_8_D







clear 
use q4_themmatic



tab id




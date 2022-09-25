####ANALISES COM OBSERVAÇÕES####

##DADOS MUTUÁRIOS
#preencher dado nulo com média
select round(avg(person_age)) as mediaIdade
from alura.dados_mutuarios;

update dados_mutuarios 
set person_age = 28
where person_age is null;


#preencher dado nulo com média
SELECT avg(person_income) 
FROM alura.dados_mutuarios;

update dados_mutuarios
set person_income = 66024
where person_income is null;


#preencher dado nulo com média
SELECT avg(person_emp_length) 
FROM alura.dados_mutuarios;

update dados_mutuarios
set person_emp_length = 4.79
where person_emp_length is null;

##------------------##

##EMPRESTIMOS
#preencher dado nulo com média
SELECT avg(loan_amnt) 
FROM alura.emprestimos;

update emprestimos
set loan_amnt = 9590
where loan_amnt is null;


#preencher dado nulo com média
SELECT avg(loan_int_rate)
FROM alura.emprestimos;

update emprestimos
set loan_int_rate = 11.02
where loan_int_rate is null;


#Renda percentual entre o valor total do empréstimo e o salário anual
UPDATE emprestimos e
	INNER join ids ON e.loan_id = ids.loan_id
	inner join dados_mutuarios dm on dm.person_id = ids.person_id 
SET e.loan_percent_income = loan_amnt / dm.person_income
where e.loan_percent_income is null;;

##------------------##

##HISTÓRICOS BANCO
#preencher dado nulo com média
select avg(cb_person_cred_hist_length)
from alura.historicos_banco;

update historicos_banco 
set cb_person_cred_hist_length = 5.81
where cb_person_cred_hist_length is null;

##------------------##

#unir as tabelas para extrair CSV
select 
	i.person_id
	,i.loan_id
	,i.cb_id
	,dm.person_age
	,dm.person_income
	,dm.person_home_ownership
	,dm.person_emp_length
	,e.loan_intent
	,e.loan_grade
	,e.loan_amnt 
	,e.loan_int_rate,
	,e.loan_status
	,e.loan_percent_income
	,hb.cb_person_default_on_file
	,hb.cb_person_cred_hist_length
from ids i
left join dados_mutuarios dm on dm.person_id = i.person_id
left join emprestimos e on e.loan_id = i.loan_id
left join historicos_banco hb on hb.cb_id = i.cb_id;

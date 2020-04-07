*** Settings ***
Documentation    Pedido de reservas
...              Para que eu possa aprovar ou reprovar
...              Sendo um anúnciante que possui anúncio cadastrado
...              Quero receber pedidos de reservas no meu dashboard

Resource    ../../resources/steps_kw.robot

Suite Setup       Logged with "brunoaraujo@papito.io"
Suite Teardown    End Session

Test Teardown    End Test

*** Test Cases ***
Receber pedido de reserva
    [tags]      todo
    Dado que estou logado como "brunoaraujo@papito.io"
    E tenmho anúncios cadastrados
    Quando o "let@gmail.com" solicita uma reserva para o meiu anúncio
    Então devo ver esta solicitação no meu dashboard
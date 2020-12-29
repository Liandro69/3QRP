Locales['en'] = {
    ['document_deleted'] = "Documento foi ~g~Apagado~w~.",
    ['document_delete_failed'] = "Documento para apagar ~r~falhou~w~.",
    ['copy_from_player'] = "Tu ~g~recebeste~w~ um formulário de outra pessoa.",
    ['from_copied_player'] = "Fromulário ~g~copiado~w~ para outra pessoa",
    ['could_not_copy_form_player'] = "Não ~r~conseguiste~w~ copiar o formulário para outra pessoa.",
    ['document_options'] = "Opçoes de Documento",
    ['public_documents'] = "Documentos Publicos",
    ['job_documents'] = "Documentos Laborais",
    ['saved_documents'] = "Documentos Guardados",
    ['close_bt'] = "Fechar",
    ['no_player_found'] = "Não encontrou pessoas",
    ['go_back'] = "Recuar",
    ['view_bt'] = "Ver",
    ['show_bt'] = "Mostrar",
    ['give_copy'] = "Dár Cópia",
    ['delete_bt'] = "Apagar",
    ['yes_delete'] = "Sim Apagar",
}

Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "FORMULÁRIO DE AFIRMAÇÃO",
          headerSubtitle = "Formulário de afirmação de cidadão.",
          elements = {
            { label = "CONTEUDO DE AFIRMAÇÃO", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "PROVA DE TESTEMUNHA",
          headerSubtitle = "Relatorio oficial de Testemunha.",
          elements = {
            { label = "DATA DA OCCORRENCIA", type = "input", value = "", can_be_emtpy = false },
            { label = "CONTEUDO DE TESTEMUNHO", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "VENDA DE VEICULO A CIDADÃO",
          headerSubtitle = "Declaração de venda de veiculo a outro cidadão.",
          elements = {
            { label = "MATRICULA", type = "input", value = "", can_be_emtpy = false },
            { label = "NOME CIDADÃO", type = "input", value = "", can_be_emtpy = false },
            { label = "PREÇO ACORDADO", type = "input", value = "", can_be_empty = false },
            { label = "OUTRA INFORMAÇÃO", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "DECLARAÇÃO DE EMPRÉSTIMO",
          headerSubtitle = "Declaração oficial de empréstimo a cidadão.",
          elements = {
            { label = "CREDOR PRIMIERO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "CREDOR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "MONTANTE EMPRESTADO", type = "input", value = "", can_be_empty = false },
            { label = "MONTANTE A PAGAR", type = "input", value = "", can_be_empty = false },
            { label = "OUTRAS INFORMAÇOES", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "DECLARAÇÃO DE VENDA DE PROPIEDADE",
          headerSubtitle = "Declaração de venda de propiedade a outro cidadão.",
          elements = {
            { label = "NOVO RESIDENTE NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "MONTANTE DA VENDA", type = "input", value = "", can_be_empty = false },
            { label = "OUTRA INFORMAÇÃO", type = "textarea", value = "I HEREBY DECLARE THAT THE AFOREMENTIONED CITIZEN HAS COMPLETED A PAYMENT WITH THE AFOREMENTIONED DEBT AMOUNT", can_be_emtpy = false, can_be_edited = false },
          }
        },
        {
          headerTitle = "CONTRATO DE SEGURADORA",
          headerSubtitle = "Declaração de venda de propiedade a outro cidadão.",
          elements = {
            { label = "NOME CLIENTE", type = "input", value = "", can_be_emtpy = false },
            { label = "ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TIPO DE SEGURO", type = "input", value = "", can_be_empty = false },
            { label = "OUTRA INFORMAÇÃO", type = "textarea", value = "Termos & Condições", can_be_emtpy = false, can_be_edited = true },
          }
        }
      },
      ["police"] = {
        {
          headerTitle = "AUTORIZAÇÃO DE ESTACIONAMENTO ESPECIAL",
          headerSubtitle = "Licença especial de estacionamento sem limite.",
          elements = {
            { label = "TITULAR PRIMEIRO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TITULAR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDO ATÉ", type = "input", value = "", can_be_empty = false },
            { label = "INFORMAÇÃO", type = "textarea", value = "THE AFOREMENTIONED CITIZEN HAS BEEN GRANTED UNLIMITED PARKING PERMIT IN EVERY CITY ZONE AND IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "PORTE DE ARMA",
          headerSubtitle = "Licença de Porte de Arma autorizado pela Policia.",
          elements = {
            { label = "TITULAR PRIMEIRO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TITULAR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDO ATÉ", type = "input", value = "", can_be_empty = false },
            { label = "INFORMAÇÃO", type = "textarea", value = "O CIDADÃO MENCIONADO DETÉM UMA AUTORIZAÇÃO DE PORTE DE ARMA QUE SERÁ VÁLIDA ATÉ A DATA DE VALIDADE PREVISTA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "REGISTO CRIMINAL LIMPO",
          headerSubtitle = "Registro oficial limpo, de uso geral, criminal.",
          elements = {
            { label = "TITULAR PRIMEIRO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TITULAR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDO ATÉ", type = "input", value = "", can_be_empty = false },
            { label = "DADOS CRIMINAIS", type = "textarea", value = "THE POLICE HEREBY DECLARES THAT THE AFOREMENTIONED CITIZEN HOLDS A CLEAR CRIMINAL RECORD. THIS RESULT IS GENERATED FROM DATA SUBMITTED IN THE CRIMINAL RECORD SYSTEM BY THE DOCUMENT SIGN DATE.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["juiz"] = {
        {
          headerTitle = "AUTORIZAÇÃO DE ESTACIONAMENTO ESPECIAL",
          headerSubtitle = "Licença especial de estacionamento sem limite.",
          elements = {
            { label = "TITULAR PRIMEIRO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TITULAR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDO ATÉ", type = "input", value = "", can_be_empty = false },
            { label = "INFORMAÇÃO", type = "textarea", value = "THE AFOREMENTIONED CITIZEN HAS BEEN GRANTED UNLIMITED PARKING PERMIT IN EVERY CITY ZONE AND IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "PORTE DE ARMA",
          headerSubtitle = "Licença de Porte de Arma autorizado pela Policia.",
          elements = {
            { label = "TITULAR PRIMEIRO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TITULAR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDO ATÉ", type = "input", value = "", can_be_empty = false },
            { label = "INFORMAÇÃO", type = "textarea", value = "O CIDADÃO MENCIONADO DETÉM UMA AUTORIZAÇÃO DE PORTE DE ARMA QUE SERÁ VÁLIDA ATÉ A DATA DE VALIDADE PREVISTA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "REGISTO CRIMINAL LIMPO",
          headerSubtitle = "Registro oficial limpo, de uso geral, criminal.",
          elements = {
            { label = "TITULAR PRIMEIRO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "TITULAR ULTIMO NOME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDO ATÉ", type = "input", value = "", can_be_empty = false },
            { label = "DADOS CRIMINAIS", type = "textarea", value = "THE POLICE HEREBY DECLARES THAT THE AFOREMENTIONED CITIZEN HOLDS A CLEAR CRIMINAL RECORD. THIS RESULT IS GENERATED FROM DATA SUBMITTED IN THE CRIMINAL RECORD SYSTEM BY THE DOCUMENT SIGN DATE.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "MEDICAL REPORT - PATHOLOGY",
          headerSubtitle = "Official medical report provided by a pathologist.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED HEALTHY WITH NO DETECTED LONGTERM CONDITIONS. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MEDICAL REPORT - PSYCHOLOGY",
          headerSubtitle = "Official medical report provided by a psychologist.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED MENTALLY HEALTHY BY THE LOWEST APPROVED PSYCHOLOGY STANDARDS. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MEDICAL REPORT - EYE SPECIALIST",
          headerSubtitle = "Official medical report provided by an eye specialist.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN WAS TESTED BY A HEALTHCARE OFFICIAL AND DETERMINED WITH A HEALTHY AND ACCURATE EYESIGHT. THIS REPORT IS VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MARIJUANA USE PERMIT",
          headerSubtitle = "Official medical marijuana usage permit for citizens.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "THE AFOREMENTIONED INSURED CITIZEN IS GRANTED, AFTER BEING THOROUGHLY EXAMINED BY A HEALTHCARE SPECIALIST, MARIJUANA USAGE PERMIT DUE TO UNDISCLOSED MEDICAL REASONS. THE LEGAL AND PERMITTED AMOUNT A CITIZEN CAN HOLD CAN NOT BE MORE THAN 100grams.", can_be_emtpy = false, can_be_edited = false },
          }
        },

      ["avocat"] = {
        {
          headerTitle = "LEGAL SERVICES CONTRACT",
          headerSubtitle = "Legal services contract provided by a lawyer.",
          elements = {
            { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESANTATION AND COVERAGE OF THE AFOREMENTIONED CITIZEN. LEGAL SERVICES ARE VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        }
      }
    }
  }

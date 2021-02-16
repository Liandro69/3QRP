-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_PawnShop = {}
local MFP = MF_PawnShop

MFP.Version = '1.0.10'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(10)
  end
end)

function MFP:GetShops()
  return {
    [1] = {
      title = 'Kevin daz drogazz',
      text  = 'Pressiona [~r~E~s~] pra falares com o Kevin.',
      loc   = { x=-1169.32, y=-1572.78, z=4.66 },
      blip  = false,

      buy = {
        [1] = {
          label       = 'Marijuana',
          item        = 'trimmedweed',
          price       = 80,
          max         = 50,
          startcount  = 0,
        },

        [2] = {
          label       = 'Metanfetamina',
          item        = 'meth',
          price       = 120,
          max         = 40,
          startcount  = 0,
        },
      },

      sell = {
        [1] = {
          label   = 'Marijuana',
          item    = 'trimmedweed',
          price   = 24,
          max     = 50,
        },

        [2] = {
          label   = 'Metanfetamina',
          item    = 'meth',
          price   = 50,
          max     = 40,
        },
      },
    },
    [2] = {
      title = 'Loja dos 500',
      text  = 'Pressiona [~r~E~s~] para falar com o vendedor.',
      loc   = { x=-1215.91, y=-1515.76, z=4.37 },
      blip  = false,

      buy = {
        [1] = {
          label       = 'Rolex',
          item        = 'rolex',
          price       = 1055,
          max         = 50,
        },

		    [2] = {
          label       = 'Oxycutter',
          item        = 'oxycutter',
          price       = 1850,
          max         = 2,
        },

        [3] = {
          label       = 'Corrente de Ouro',
          item        = '2ct_gold_chain',
          price       = 495,
          max         = 100,
        },

        [4] = {
          label       = 'Perola',
          item        = 'pearl_b',
          price       = 880,
          max         = 5000,
        },

        [5] = {
          label       = 'Anel',
          item        = 'anel',
          price       = 1500,
          max         = 50,
        },

        [6] = {
          label       = 'Caixa de Diamantes',
          item        = 'dia_box',
          price       = 5000,
          max         = 10,
        },

      },

      sell = {
        [1] = {
          label       = 'Rolex',
          item        = 'rolex',
          price       = 515,
          max         = 500,
        },

		    [2] = {
          label       = 'Oxycutter',
          item        = 'oxycutter',
          price       = 650,
          max         = 2,
        },

        [3] = {
          label       = 'Corrente de Ouro',
          item        = '2ct_gold_chain',
          price       = 495,
          max         = 500,
        },

        [4] = {
          label       = 'Perola',
          item        = 'pearl_b',
          price       = 120,
          max         = 5000,
        },

        [5] = {
          label       = 'Anel',
          item        = 'anel',
          price       = 800,
          max         = 50,
        },

        [6] = {
          label       = 'Caixa de Diamantes',
          item        = 'dia_box',
          price       = 1725,
          max         = 10,
        },

      },

    },
    [3] = {
      title   = 'Black Market',
      text    = 'Press [~r~E~s~] to interact with the Black Market.',
      loc     = {x=830.43,y=-2171.67,z=-30.27},
      blip    = false,

      buy = {
        [1] = {
          label       = 'Minigun',
          item        = 'weapon_minigun',
          price       = 999999999,
          max         = 1,
          startcount  = 0,
          weapon      = true,
        },

        [2] = {
          label       = 'Assault Shotgun',
          item        = 'weapon_assaultshotgun',
          price       = 999999999,
          max         = 5,
          startcount  = 0,
          weapon      = true,
        },

        [3] = {
          label       = 'Pump Shotgun',
          item        = 'weapon_pumpshotgun',
          price       = 999999999,
          max         = 5,
          startcount  = 0,
          weapon      = true,
        },
      },

      sell = {
        [1] = {
          label   = 'Minigun',
          item    = 'weapon_minigun',
          price   = 999999999,
          max     = 1,
          weapon  = true,
        },

        [2] = {
          label   = 'Assault Shotgun',
          item    = 'weapon_assaultshotgun',
          price   = 99999999,
          max     = 5,
          weapon  = true,
        },

        [3] = {
          label   = 'Pump Shotgun',
          item    = 'weapon_pumpshotgun',
          price   = 99999999,
          max     = 5,
          weapon  = true,
        },
      },
    }
  }
end
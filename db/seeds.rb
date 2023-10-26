# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Data:

[
  {
    client: {
      name: "Jon Doe"
    },
    custom_fields: [
      {
        field_type: CustomField::TYPE_STRING,
        name: 'color',
      },
      {
        field_type: CustomField::TYPE_NUMBER,
        name: 'height_feet',
      },
      {
        field_type: CustomField::TYPE_ENUM,
        name: 'zoning',
        enum_options: ['commericial', 'residential', 'mixed_use']
      }
    ],
    buildings: [
      {
        address_1: '123 Main Street',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11215',
        custom_fields: {
          color: 'aqua marine',
          height_feet: 120.6,
          zoning: 'residential'
        }
      },
      {
        address_1: '9583 Park Ave',
        address_2: '#56b',
        city: 'New York',
        state: 'NY',
        zip: '10001',
        custom_fields: {
          color: 'periwinkle',
          height_feet: 54,
          zoning: 'mixed_use'
        }
      },
      {
        address_1: '2346 Prospect Park West',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11215',
        custom_fields: {
          color: 'cerulean',
          height_feet: 34.1,
          zoning: 'commercial'
        }
      }
    ]
  },
  {
    client: {
      name: "Marko Hùng"
    },
    custom_fields: [
      {
        field_type: CustomField::TYPE_STRING,
        name: 'garden_description',
      },
      {
        field_type: CustomField::TYPE_NUMBER,
        name: 'driveway_length_feet',
      },
      {
        field_type: CustomField::TYPE_ENUM,
        name: 'sloped_roof',
        enum_options: ['yes', 'no']
      }
    ],
    buildings: [
      {
        address_1: '5395 Loop St.',
        city: 'Ann Arbor',
        state: 'MI',
        zip: '49324',
        custom_fields: {
          garden_description: 'lush and green',
          driveway_length_feet: 32.43,
          sloped_roof: 'no'
        }
      },
      {
        address_1: '2346 Union Street',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11215',
        custom_fields: {
          garden_description: nil,
          driveway_length_feet: 12,
          sloped_roof: 'yes'
        }
      },
      {
        address_1: '56936 Lincoln Pl',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11222',
        custom_fields: {
          garden_description: 'zen garden',
          driveway_length_feet: nil,
          sloped_roof: 'yes'
        }
      }
    ]
  },
  {
    client: {
      name: "Monika Rogier"
    },
    custom_fields: [
      {
        field_type: CustomField::TYPE_STRING,
        name: 'description',
      },
      {
        field_type: CustomField::TYPE_NUMBER,
        name: 'swimming_pool_depth_feet',
      }
    ],
    buildings: [
      {
        address_1: '89 9th St',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11215',
        custom_fields: {
          description: 'lots of natural light',
          swimming_pool_depth_feet: 8.3,
        }
      },
      {
        address_1: '34 15th St',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11218',
        custom_fields: {
          description: 'great subway access',
          swimming_pool_depth_feet: nil,
        }
      },
      {
        address_1: '90 Windsor Pl',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11217',
        custom_fields: {
          description: nil,
          swimming_pool_depth_feet: 3,
        }
      }
    ]
  },
  {
    client: {
      name: "Pachacútec Brande"
    },
    custom_fields: [
      {
        field_type: CustomField::TYPE_STRING,
        name: 'lobby_tile_design',
      },
      {
        field_type: CustomField::TYPE_NUMBER,
        name: 'frontage_length_feet',
      },
      {
        field_type: CustomField::TYPE_ENUM,
        name: 'has_gym',
        enum_options: ['yes', 'no']
      }
    ],
    buildings: [
      {
        address_1: '378 Front St',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11270',
        custom_fields: {
          lobby_tile_design: 'diamond',
          frontage_length_feet: 20.25,
          has_gym: 'no',
        }
      },
      {
        address_1: '3 Berkley Pl',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11213',
        custom_fields: {
          lobby_tile_design: 'subway',
          frontage_length_feet: nil,
          has_gym: 'no',
        }
      },
      {
        address_1: '4 Flatbush Ave',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11210',
        custom_fields: {
          lobby_tile_design: 'subway',
          frontage_length_feet: 145.65,
          has_gym: 'yes',
        }
      }
    ]
  },
  {
    client: {
      name: "Kaysen Alida"
    },
    custom_fields: [
      {
        field_type: CustomField::TYPE_NUMBER,
        name: 'living_room_height_feet',
      },
      {
        field_type: CustomField::TYPE_NUMBER,
        name: 'number_of_bathrooms',
      }
    ],
    buildings: [
      {
        address_1: '4853 Water St',
        address_2: 'Unit A',
        city: 'Brooklyn',
        state: 'NY',
        zip: '12250',
        custom_fields: {
          living_room_height_feet: 10.4,
          number_of_bathrooms: 2.5,
        }
      },
      {
        address_1: '58 Manhattan Ave',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11211',
        custom_fields: {
          living_room_height_feet: 4,
          number_of_bathrooms: nil,
        }
      },
      {
        address_1: '96 Java St',
        city: 'Brooklyn',
        state: 'NY',
        zip: '11212',
        custom_fields: {
          living_room_height_feet: 23.9,
          number_of_bathrooms: 1,
        }
      }
    ]
  }
].each do |data|
  client = Client.find_or_create_by!(data[:client])

  data[:custom_fields].each do |custom_field_attrs|
    custom_field = CustomField.find_or_create_by!(
      client_id: client.id,
      field_type: custom_field_attrs[:field_type],
      name: custom_field_attrs[:name],
    )
    custom_field.update!(custom_field_attrs)
  end

  data[:buildings].each do |building_attrs|
    building = Building.find_or_create_by!(
      client_id: client.id,
      address_1: building_attrs[:address_1],
      address_2: building_attrs[:address_2],
      city: building_attrs[:city],
      state: building_attrs[:state],
      zip: building_attrs[:zip]
    )
    building.update!(building_attrs)
  end
end

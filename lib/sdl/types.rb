module SDL
  SCALAR_TYPES = %i[
    id
    string
    boolean
    integer
    float
    decimal
    date
    datetime
    text
    binary
  ]

  TYPES = SCALAR_TYPES + %i[
    enum
    belongs_to
    has_one
    has_many
    has_one_attached
    has_many_attached
  ]
end

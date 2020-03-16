module Form exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, form, h2, input, label, text)
import Html.Attributes exposing (for, id, style, type_)
import Html.Events exposing (onInput)


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    { name = ""
    , password = ""
    , passwordAgain = ""
    }


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Form" ]
        , form []
            [ viewInput NameForm
            , viewInput PasswordForm
            , viewInput PasswordAgainForm
            , viewValidation model
            ]
        ]


type FormKind
    = NameForm
    | PasswordForm
    | PasswordAgainForm


viewInput : FormKind -> Html Msg
viewInput formKind =
    case formKind of
        NameForm ->
            div []
                [ label [ for "name" ] [ text "Name" ]
                , input
                    [ id "name"
                    , type_ "text"
                    , onInput Name
                    ]
                    []
                ]

        PasswordForm ->
            div []
                [ label [ for "password" ] [ text "Password" ]
                , input
                    [ id "password"
                    , type_ "password"
                    , onInput Password
                    ]
                    []
                ]

        PasswordAgainForm ->
            div []
                [ label [ for "passwordAgain" ] [ text "Password (Again)" ]
                , input
                    [ id "passwordAgain"
                    , type_ "password"
                    , onInput PasswordAgain
                    ]
                    []
                ]


viewValidation : Model -> Html msg
viewValidation model =
    if model.passwordAgain /= "" then
        if model.password == model.passwordAgain then
            div [ style "color" "green" ] [ text "OK" ]

        else
            div [ style "color" "red" ] [ text "Passwords do not match!" ]

    else
        div [] []

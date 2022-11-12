package errors

import (
	"github.com/pkg/errors"
)

type ServerError struct {
	Code int
	Msg  string
	Name string
	Data interface{}
	Err error
}

type ErrorPolicy struct {
	Code int
	Name string
}

var (
	BAD_REQUEST = ErrorPolicy{
		Code: 400,
		Name: "BAD_REQUEST",
	}
)

func (e *ServerError) Error() string {
	return e.Msg
}

func NewError(code int, msg string, err error) *ServerError {
	if err == nil {
		err = errors.New(msg)
	} else {
		err = errors.Wrap(err, err.Error())
	}
	return &ServerError{
		Msg:  err.Error(),
		Code: code,
		Err: err,
	}
}

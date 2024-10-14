package util

const (
	USD   = "USD"
	IND   = "IND"
	randi = "rand"
)

func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, IND, randi:
		return true
	}
	return false
}

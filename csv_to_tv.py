"""
Module: csv_to_tv

Program to read CSV formatted ALU test vector table and print them out in the
format needed for the ALU test vector file.
"""

def pad(hex_str, length):
    """Pads hex_str with leading zeros to get to length."""
    return "0" * (length - len(hex_str)) + hex_str

file = open("test-vector-table.csv", "r")

# skip the header row
file.readline()

for line in file:
    fields = line.split(",")
    a_padded = pad(fields[-6], 8)
    b_padded = pad(fields[-5], 8)
    y_padded = pad(fields[-4], 8)
    print("%s_%s_%s_%s_%s_%s_%s" % (fields[-7], a_padded, b_padded, y_padded,
                                    fields[-3], fields[-2], fields[-1][0]))

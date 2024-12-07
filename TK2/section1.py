import csv

input_data = [
    {"y": 0,   "xr": 317, "x_values": [0]},
    {"y": 413, "xr": 143, "x_values": [176, 486, 798, 1110, 1425, 1734]},
    {"y": 548, "xr": 88,  "x_values": [107, 292, 479, 675, 863, 1050, 1245, 1435, 1626, 18111]},
    {"y": 608, "xr": 65,  "x_values": [350, 484, 617, 753, 890, 1026, 1161, 13298, 1434, 1571]},
    {"y": 642, "xr": 50,  "x_values": [481, 586, 691, 801, 902, 1010, 1218, 1224, 1333, 1433]},
    {"y": 660, "xr": 41,  "x_values": [556, 651, 740, 831, 912, 1005, 1090, 1180, 1270, 1346]},
    {"y": 680, "xr": 35,  "x_values": [631, 699, 769, 849, 922, 993, 1068, 1141, 1212, 1277]},
    {"y": 687, "xr": 29,  "x_values": [673, 737, 800, 864, 926, 989, 1055, 1118, 1184, 1249]},
    {"y": 695, "xr": 27,  "x_values": [700, 755, 817, 877, 935, 991, 1047, 1104, 1165, 1214]},
    {"y": 702, "xr": 25,  "x_values": [729, 775, 826, 879, 938, 985, 1040, 1091, 1150, 1193]},
]

time_stamps = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540]
real_y_values = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45]

def compute_dx_values(x_ref, x_list):
    extended = [0] + x_list
    increments = []
    for i in range(1, len(extended)):
        dx = (2.5 / x_ref) * (extended[i] - extended[i - 1])
        increments.append(dx)
    return increments

def accumulate_values(increments):
    cumulative = []
    running_total = 0
    for val in increments:
        running_total += val
        cumulative.append(running_total)
    return cumulative

final_results = {}

for idx, record in enumerate(input_data):
    xr_value = record["xr"]
    pixel_xs = record["x_values"]

    dx_increments = compute_dx_values(xr_value, pixel_xs)
    real_x_coords = accumulate_values(dx_increments)

    final_results[f"frame_{idx}"] = real_x_coords

csv_filename = "processed_coordinates.csv"
with open(csv_filename, mode="w", newline="") as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["t", "real_x_values", "real_y_value"])
    
    for i, (key, xcoords) in enumerate(final_results.items()):
        x_str = ";".join(map(str, xcoords))
        writer.writerow([time_stamps[i], x_str, real_y_values[i]])

print(f"Data successfully written to {csv_filename}")
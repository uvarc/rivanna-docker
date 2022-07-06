from deeplabcut.utils import auxfun_models, auxiliaryfunctions
from pathlib import Path

dlc_path = Path(auxiliaryfunctions.get_deeplabcut_path())
networks = [
    "resnet_50",
    "resnet_101",
    "resnet_152",
    "mobilenet_v2_1.0",
    "mobilenet_v2_0.75",
    "mobilenet_v2_0.5",
    "mobilenet_v2_0.35",
    "efficientnet-b0",
    "efficientnet-b3",
    "efficientnet-b6",
]
for network in networks:
    auxfun_models.Check4weights(network, dlc_path, 1)

import 'package:admin/models/plants/md_plant.dart';
import 'package:admin/models/request/md_request_plant.dart';
import 'package:admin/models/user/md_admin.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/models/workplace/md_workplace.dart';

List<WorkplaceModel> WORKPLACE_DUMMY_DATA = [
  WorkplaceModel(
    id: 1,
    plantName: "Basil",
    scientificName: "Ocimum basilicum",
    description:
        "Basil is known for its use in cooking and medicinal properties.",
    images: ["basil_image1.jpg", "basil_image2.jpg"],
    user: UserModel(
      id: 1,
      name: "Anna Williams",
      email: "anna.williams@example.com",
      role: "User",
      emailVerifiedAt: "2024-05-11T12:30:00",
      createdAt: "2024-03-21T09:30:00",
      updatedAt: "2024-10-25T11:30:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin A",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-04-05T10:15:00",
      createdAt: "2024-02-01T08:00:00",
      updatedAt: "2024-10-26T12:00:00",
    ),
    status: "In Progress",
    createdAt: "2024-10-01T11:00:00",
    updatedAt: "2024-10-25T11:30:00",
  ),
  WorkplaceModel(
    id: 3,
    plantName: "Thyme",
    scientificName: "Thymus vulgaris",
    description:
        "Thyme has antiseptic properties and is used for respiratory issues.",
    images: ["thyme_image1.jpg", "thyme_image2.jpg"],
    user: UserModel(
      id: 3,
      name: "Clara Mitchell",
      email: "clara.mitchell@example.com",
      role: "User",
      emailVerifiedAt: "2024-04-08T10:45:00",
      createdAt: "2024-03-05T13:00:00",
      updatedAt: "2024-10-20T14:30:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin A",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-02-25T09:30:00",
      createdAt: "2024-01-10T11:30:00",
      updatedAt: "2024-10-20T16:00:00",
    ),
    status: "In Progress",
    createdAt: "2024-09-01T12:00:00",
    updatedAt: "2024-10-20T14:30:00",
  ),
  WorkplaceModel(
    id: 4,
    plantName: "Eucalyptus",
    scientificName: "Eucalyptus globulus",
    description:
        "Eucalyptus oil is often used for respiratory issues and pain relief.",
    images: ["eucalyptus_image1.jpg", "eucalyptus_image2.jpg"],
    user: UserModel(
      id: 4,
      name: "Daniel Harris",
      email: "daniel.harris@example.com",
      role: "User",
      emailVerifiedAt: "2024-03-30T11:00:00",
      createdAt: "2024-02-20T10:00:00",
      updatedAt: "2024-10-24T12:00:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin D",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-03-15T08:45:00",
      createdAt: "2024-01-08T09:00:00",
      updatedAt: "2024-10-24T14:00:00",
    ),
    status: "Completed",
    createdAt: "2024-10-10T09:30:00",
    updatedAt: "2024-10-24T12:00:00",
  ),
  WorkplaceModel(
    id: 7,
    plantName: "Garlic",
    scientificName: "Allium sativum",
    description: "Garlic is well-known for its immune-boosting properties.",
    images: ["garlic_image1.jpg", "garlic_image2.jpg"],
    user: UserModel(
      id: 7,
      name: "Sophia Lee",
      email: "sophia.lee@example.com",
      role: "User",
      emailVerifiedAt: "2024-03-01T17:45:00",
      createdAt: "2024-01-30T15:00:00",
      updatedAt: "2024-10-22T09:30:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin G",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-01-18T08:00:00",
      createdAt: "2024-01-05T10:15:00",
      updatedAt: "2024-10-22T11:00:00",
    ),
    status: "In Progress",
    createdAt: "2024-09-18T11:15:00",
    updatedAt: "2024-10-22T09:30:00",
  ),
  WorkplaceModel(
    id: 8,
    plantName: "Thyme",
    scientificName: "Thymus vulgaris",
    description:
        "Thyme has antiseptic properties and is used for respiratory issues.",
    images: ["thyme_image1.jpg", "thyme_image2.jpg"],
    user: UserModel(
      id: 3,
      name: "Clara Mitchell",
      email: "clara.mitchell@example.com",
      role: "User",
      emailVerifiedAt: "2024-04-08T10:45:00",
      createdAt: "2024-03-05T13:00:00",
      updatedAt: "2024-10-20T14:30:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin A",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-02-25T09:30:00",
      createdAt: "2024-01-10T11:30:00",
      updatedAt: "2024-10-20T16:00:00",
    ),
    status: "Completed",
    createdAt: "2024-10-10T10:00:00",
    updatedAt: "2024-10-20T14:30:00",
  ),
];

//====================================================================
List<RequestPlantModel> REQUEST_DUMMY_DATA = [
  RequestPlantModel(
    id: 1,
    plantName: "Basil",
    scientificName: "Ocimum basilicum",
    description:
        "Basil is known for its use in cooking and medicinal properties.",
    images: ["basil_image1.jpg", "basil_image2.jpg"],
    user: UserModel(
      id: 1,
      name: "Anna Williams",
      email: "anna.williams@example.com",
      role: "User",
      emailVerifiedAt: "2024-05-11T12:30:00",
      createdAt: "2024-03-21T09:30:00",
      updatedAt: "2024-10-25T11:30:00",
    ),
    admin: null,
    status: "Pending",
    createdAt: "2024-10-01T11:00:00",
    updatedAt: "2024-10-25T11:30:00",
  ),
  RequestPlantModel(
    id: 2,
    plantName: "Rosemary",
    scientificName: "Rosmarinus officinalis",
    description: "Rosemary is commonly used to improve memory and digestion.",
    images: ["rosemary_image1.jpg", "rosemary_image2.jpg"],
    user: UserModel(
      id: 2,
      name: "Brian Scott",
      email: "brian.scott@example.com",
      role: "User",
      emailVerifiedAt: "2024-03-15T14:00:00",
      createdAt: "2024-01-20T16:00:00",
      updatedAt: "2024-10-27T10:30:00",
    ),
    admin: null,
    status: "Pending",
    createdAt: "2024-09-12T08:00:00",
    updatedAt: "2024-10-27T10:30:00",
  ),
  RequestPlantModel(
    id: 3,
    plantName: "Thyme",
    scientificName: "Thymus vulgaris",
    description:
        "Thyme has antiseptic properties and is used for respiratory issues.",
    images: ["thyme_image1.jpg", "thyme_image2.jpg"],
    user: UserModel(
      id: 3,
      name: "Clara Mitchell",
      email: "clara.mitchell@example.com",
      role: "User",
      emailVerifiedAt: "2024-04-08T10:45:00",
      createdAt: "2024-03-05T13:00:00",
      updatedAt: "2024-10-20T14:30:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin C",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-02-25T09:30:00",
      createdAt: "2024-01-10T11:30:00",
      updatedAt: "2024-10-20T16:00:00",
    ),
    status: "In Progress",
    createdAt: "2024-09-01T12:00:00",
    updatedAt: "2024-10-20T14:30:00",
  ),
  RequestPlantModel(
    id: 4,
    plantName: "Eucalyptus",
    scientificName: "Eucalyptus globulus",
    description:
        "Eucalyptus oil is often used for respiratory issues and pain relief.",
    images: ["eucalyptus_image1.jpg", "eucalyptus_image2.jpg"],
    user: UserModel(
      id: 4,
      name: "Daniel Harris",
      email: "daniel.harris@example.com",
      role: "User",
      emailVerifiedAt: "2024-03-30T11:00:00",
      createdAt: "2024-02-20T10:00:00",
      updatedAt: "2024-10-24T12:00:00",
    ),
    admin: null,
    status: "Pending",
    createdAt: "2024-10-10T09:30:00",
    updatedAt: "2024-10-24T12:00:00",
  ),
  RequestPlantModel(
    id: 5,
    plantName: "Sage",
    scientificName: "Salvia officinalis",
    description: "Sage is used for cognitive health and reducing inflammation.",
    images: ["sage_image1.jpg", "sage_image2.jpg"],
    user: UserModel(
      id: 5,
      name: "Emma Johnson",
      email: "emma.johnson@example.com",
      role: "User",
      emailVerifiedAt: "2024-04-02T13:30:00",
      createdAt: "2024-03-12T12:00:00",
      updatedAt: "2024-10-26T10:15:00",
    ),
    admin: AdminModel(
      id: 5,
      name: "Admin E",
      email: "adminE@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-02-20T07:00:00",
      createdAt: "2024-01-05T11:45:00",
      updatedAt: "2024-10-26T10:30:00",
    ),
    status: "In Review",
    createdAt: "2024-09-25T14:30:00",
    updatedAt: "2024-10-26T10:15:00",
  ),
  RequestPlantModel(
    id: 6,
    plantName: "Lemongrass",
    scientificName: "Cymbopogon citratus",
    description:
        "Lemongrass is used in cooking and has antimicrobial properties.",
    images: ["lemongrass_image1.jpg", "lemongrass_image2.jpg"],
    user: UserModel(
      id: 6,
      name: "Ethan Clark",
      email: "ethan.clark@example.com",
      role: "User",
      emailVerifiedAt: "2024-05-04T15:30:00",
      createdAt: "2024-03-10T16:30:00",
      updatedAt: "2024-10-23T11:45:00",
    ),
    admin: AdminModel(
      id: 6,
      name: "Admin F",
      email: "adminF@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-03-22T09:30:00",
      createdAt: "2024-02-18T12:30:00",
      updatedAt: "2024-10-23T13:00:00",
    ),
    status: "In Progress",
    createdAt: "2024-10-01T10:30:00",
    updatedAt: "2024-10-23T11:45:00",
  ),
  RequestPlantModel(
    id: 7,
    plantName: "Garlic",
    scientificName: "Allium sativum",
    description: "Garlic is well-known for its immune-boosting properties.",
    images: ["garlic_image1.jpg", "garlic_image2.jpg"],
    user: UserModel(
      id: 7,
      name: "Sophia Lee",
      email: "sophia.lee@example.com",
      role: "User",
      emailVerifiedAt: "2024-03-01T17:45:00",
      createdAt: "2024-01-30T15:00:00",
      updatedAt: "2024-10-22T09:30:00",
    ),
    admin: AdminModel(
      id: 1,
      name: "Admin G",
      email: "adminA@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-01-18T08:00:00",
      createdAt: "2024-01-05T10:15:00",
      updatedAt: "2024-10-22T11:00:00",
    ),
    status: "In Progress",
    createdAt: "2024-09-18T11:15:00",
    updatedAt: "2024-10-22T09:30:00",
  ),
  RequestPlantModel(
    id: 8,
    plantName: "Ginger",
    scientificName: "Zingiber officinale",
    description: "Ginger is used for digestive issues and reducing nausea.",
    images: ["ginger_image1.jpg", "ginger_image2.jpg"],
    user: UserModel(
      id: 8,
      name: "Liam Brown",
      email: "liam.brown@example.com",
      role: "User",
      emailVerifiedAt: "2024-03-10T18:00:00",
      createdAt: "2024-02-14T13:30:00",
      updatedAt: "2024-10-26T09:00:00",
    ),
    admin: AdminModel(
      id: 8,
      name: "Admin H",
      email: "adminH@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-02-02T11:00:00",
      createdAt: "2024-01-10T08:30:00",
      updatedAt: "2024-10-26T10:45:00",
    ),
    status: "Completed",
    createdAt: "2024-10-11T12:45:00",
    updatedAt: "2024-10-26T09:00:00",
  ),
  RequestPlantModel(
    id: 9,
    plantName: "Mint",
    scientificName: "Mentha",
    description:
        "Mint is known for its soothing effect on the stomach and respiratory system.",
    images: ["mint_image1.jpg", "mint_image2.jpg"],
    user: UserModel(
      id: 9,
      name: "James Martin",
      email: "james.martin@example.com",
      role: "User",
      emailVerifiedAt: "2024-04-12T14:15:00",
      createdAt: "2024-03-20T16:00:00",
      updatedAt: "2024-10-21T13:30:00",
    ),
    admin: AdminModel(
      id: 9,
      name: "Admin I",
      email: "adminI@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-03-08T10:30:00",
      createdAt: "2024-02-05T09:15:00",
      updatedAt: "2024-10-21T15:00:00",
    ),
    status: "In Review",
    createdAt: "2024-09-30T13:00:00",
    updatedAt: "2024-10-21T13:30:00",
  ),
  RequestPlantModel(
    id: 10,
    plantName: "Chamomile",
    scientificName: "Matricaria chamomilla",
    description: "Chamomile is used for relaxation and to aid sleep.",
    images: ["chamomile_image1.jpg", "chamomile_image2.jpg"],
    user: UserModel(
      id: 10,
      name: "Olivia Davis",
      email: "olivia.davis@example.com",
      role: "User",
      emailVerifiedAt: "2024-02-20T16:30:00",
      createdAt: "2024-01-25T14:00:00",
      updatedAt: "2024-10-28T09:00:00",
    ),
    admin: AdminModel(
      id: 10,
      name: "Admin J",
      email: "adminJ@example.com",
      role: "Admin",
      emailVerifiedAt: "2024-01-05T13:30:00",
      createdAt: "2024-01-01T12:00:00",
      updatedAt: "2024-10-28T09:30:00",
    ),
    status: "Completed",
    createdAt: "2024-10-20T14:00:00",
    updatedAt: "2024-10-28T09:00:00",
  ),
];

//===========================================================================

List<PlantsModel> PLANTS_DUMMY_DATA = [
  PlantsModel(
    id: 1,
    name: "Aloe Vera",
    scientificName: "Aloe barbadensis miller",
    description:
        "Aloe Vera is known for its soothing and healing properties for skin irritations and burns.",
    ailment: "Burns, skin irritations, cuts",
    cover: "https://example.com/aloe_vera_cover.jpg",
    images: [
      "https://example.com/aloe_vera1.jpg",
      "https://example.com/aloe_vera2.jpg"
    ],
    status: "Available",
    like: 150,
    admin: AdminModel(name: "Dr. Smith"),
    createdAt: "2024-10-01",
    updatedAt: "2024-10-20",
  ),
  PlantsModel(
    id: 2,
    name: "Chamomile",
    scientificName: "Matricaria chamomilla",
    description:
        "Chamomile is commonly used to help with sleep and relaxation, and can reduce inflammation.",
    ailment: "Anxiety, insomnia, digestive issues",
    cover: "https://example.com/chamomile_cover.jpg",
    images: [
      "https://example.com/chamomile1.jpg",
      "https://example.com/chamomile2.jpg"
    ],
    status: "Available",
    like: 100,
    admin: AdminModel(name: "Dr. Johnson"),
    createdAt: "2024-09-15",
    updatedAt: "2024-10-18",
  ),
  PlantsModel(
    id: 3,
    name: "Lavender",
    scientificName: "Lavandula angustifolia",
    description:
        "Lavender is widely used for its calming effects and can be helpful for headaches and insomnia.",
    ailment: "Stress, headaches, insomnia",
    cover: "https://example.com/lavender_cover.jpg",
    images: [
      "https://example.com/lavender1.jpg",
      "https://example.com/lavender2.jpg"
    ],
    status: "Out of Stock",
    like: 80,
    admin: AdminModel(name: "Dr. Brown"),
    createdAt: "2024-08-10",
    updatedAt: "2024-10-25",
  ),
  PlantsModel(
    id: 4,
    name: "Peppermint",
    scientificName: "Mentha × piperita",
    description:
        "Peppermint is known for relieving digestive problems and soothing sore muscles.",
    ailment: "Digestive issues, muscle pain, headaches",
    cover: "https://example.com/peppermint_cover.jpg",
    images: [
      "https://example.com/peppermint1.jpg",
      "https://example.com/peppermint2.jpg"
    ],
    status: "Available",
    like: 120,
    admin: AdminModel(name: "Dr. Davis"),
    createdAt: "2024-07-05",
    updatedAt: "2024-10-27",
  ),
  PlantsModel(
    id: 5,
    name: "Ginger",
    scientificName: "Zingiber officinale",
    description:
        "Ginger is used for nausea, digestive problems, and has anti-inflammatory properties.",
    ailment: "Nausea, digestion, inflammation",
    cover: "https://example.com/ginger_cover.jpg",
    images: [
      "https://example.com/ginger1.jpg",
      "https://example.com/ginger2.jpg"
    ],
    status: "Available",
    like: 140,
    admin: AdminModel(name: "Dr. Evans"),
    createdAt: "2024-06-25",
    updatedAt: "2024-10-15",
  ),
  PlantsModel(
    id: 6,
    name: "Sage",
    scientificName: "Salvia officinalis",
    description:
        "Sage is used for cognitive health, reducing inflammation, and has anti-inflammatory properties.",
    ailment: "Cognitive issues, inflammation, pain",
    cover: "https://example.com/sage_cover.jpg",
    images: ["https://example.com/sage1.jpg", "https://example.com/sage2.jpg"],
    status: "Available",
    like: 160,
    admin: AdminModel(name: "Dr. Wilson"),
    createdAt: "2024-05-20",
    updatedAt: "2024-10-12",
  ),
  PlantsModel(
    id: 7,
    name: "Rose",
    scientificName: "Rosa canina",
    description:
        "Rose is known for its relaxing effects and has anti-inflammatory properties.",
    ailment: "Relaxation, inflammation, pain",
    cover: "https://example.com/rose_cover.jpg",
    images: ["https://example.com/rose1.jpg", "https://example.com/rose2.jpg"],
    status: "Available",
    like: 180,
    admin: AdminModel(name: "Dr. Taylor"),
    createdAt: "2024-04-15",
    updatedAt: "2024-10-09",
  ),
  PlantsModel(
    id: 8,
    name: "Tulip",
    scientificName: "Tulipa",
    description:
        "Tulip is known for its relaxing effects and has anti-inflammatory properties.",
    ailment: "Relaxation, inflammation, pain",
    cover: "https://example.com/tulip_cover.jpg",
    images: [
      "https://example.com/tulip1.jpg",
      "https://example.com/tulip2.jpg"
    ],
    status: "Available",
    like: 200,
    admin: AdminModel(name: "Dr. Anderson"),
    createdAt: "2024-03-10",
    updatedAt: "2024-10-06",
  ),
];
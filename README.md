A GitHub action for generating [Publish](https://github.com/JohnSundell/Publish) static sites that are hosted on GitHub.


## Instructions

1. Generate your deploy key with the following command.

    ```sh
    ssh-keygen -o -a 100 -t ed25519 -C "$(git config user.email)" -f gh-pages -N ""
    # You will get 2 files:
    #   gh-pages.pub (public key)
    #   gh-pages     (private key)
    ```

2. Add SSH deploy key on GitHub.com Go to **Repository Settings**

    - Go to **Deploy Keys** and add your public key as `Public key of ACTIONS_DEPLOY_KEY` with **Allow write access** checked

    | Add your public key | Success |
    |---|---|
    | ![Add your public key](./.github/images/deploy-keys-1.jpg) | ![Success](./.github/images/deploy-keys-2.jpg) |

    - Go to **Secrets** and add your private key as `ACTIONS_DEPLOY_KEY`

    | Add your private key | Success |
    |---|---|
    | ![Add your private key](./.github/images/secrets-1.jpg) | ![Success](./.github/images/secrets-2.jpg) |

3. Add your workflow setting YAML file `.github/workflows/gh-pages.yml` and push to the default branch.

    ```yaml
    name: Github Pages

    on:
      push:
        branches:
        - master

    jobs:
      gh-pages:
        runs-on: ubuntu-latest
        container:
          image: "swift:5.4"
        steps:
        - name: Checkout
          uses: actions/checkout@v1
            
        - name: Build Publish
          run: |
            git clone https://github.com/JohnSundell/Publish.git
            cd Publish
            make

        - name: Generate Site
          run: publish generate

        - name: Deploy
          uses: peaceiris/actions-gh-pages@v2
          env:
            ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_DEPLOY_KEY }}
            PUBLISH_BRANCH: gh-pages
            PUBLISH_DIR: ./Output
    ```

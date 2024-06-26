@{
    'runs-on'='ubuntu-latest'
    'permissions' = @{
        'contents'='read'
        'packages'='write'
    }
    steps = @(
        @{
            'name'='Checkout repository'
            'uses'='actions/checkout@v4'
        },
        @{
            'name'='Log in to the Container registry'
            'uses'='docker/login-action@master'
            'with'=@{
                'registry'='${{ env.REGISTRY }}'
                'username'='${{ github.actor }}'
                'password'='${{ secrets.GITHUB_TOKEN }}'
            }
        },
        @{
            'name'='Extract metadata (tags, labels) for Docker'
            'id'='meta'
            'uses'='docker/metadata-action@master'
            'with'=@{
                'images'='${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}'
            }
        },
        @{
            'name'='Build and push Docker image'
            'uses'='docker/build-push-action@master'
            'with'=@{
                'context'='.'
                'push'='true'
                'tags'='${{ steps.meta.outputs.tags }}'
                'labels'='${{ steps.meta.outputs.labels }}'
            }
        }
        
    )
}
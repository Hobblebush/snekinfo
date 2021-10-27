
# Using a feature branch in Git

Use this process for any non-trivial change to the project.

## Step 1: New branch

Come up with a short two or three word title for the change you're planning to
make. For this example, it'll be ```new-feature```.

```
$ git checkout -b new-feature
```

## Step 2: Make the changes

 * This should be a self-contained change, taking the program from
   a working version to a new working version.
 * The change shouldn't be too big. Changes that take multiple full work
   days are probably too big.

## Step 3: Manual test

 * Make sure that all the things you added minimally work.
 * Make sure all the things that you touched still work.

## Step 4: Commit changes locally

 * The ```git add``` command should be run from the root directory
   of the project.
 * The commit message (here "Added new feature") should quickly describe
   the changes made.

```
$ git add -A .
$ git commit -m 'Added new feature'
```

## Step 5: Push to remote repository, create pull request

```
$ git push
```

This will error out, giving a recommended command to create the remote branch.
Do that.

That will give a link to create a pull request (sometimes "merge request"), do
that.

## Step 6: Code review

Conceptually, someone else will review the code and suggest changes.

## Step 7: Resolve merge conflicts

If the pull request cannot be merged due to merge conflicts, the issues
can be resolved in the feature branch.

```
$ git pull origin main
```

If the output complains about conflicted files, edit each file to
resolve that conflict.

For each resolved conflict, add the file:

```
$ git add path/to/resolved.file
```

If there were any conflicts, commit and push the merge.

```
$ git commit -m 'Merge changes from main'
$ git push
```

## Step 8: Merge pull request

Someone presses the "merge" button in the browser, optimally the person who
approved the code review step.

## Step 9: Pull the change to local main

```
$ git checkout main
$ git pull
```


